//
//  MazeDataGenerate.swift
//  Maze
//
//  Created by Janiece Eleonour on 11.09.2024.
//

import SwiftUI

struct MazeDataGenerate: View {
    let category: MazeCategory
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var mazeData: MazeData?
    @State private var mazeGenerate: MazeGenerate?
    @State private var rows: Int = 10
    @State private var columns: Int = 10
    @State private var isDisabled = true
    
    @State private var birthLimit: Int = 3
    @State private var deathLimit: Int = 6
    @State private var stepDelay: Double = 0.5
    @State private var isAutomatic: Bool = false
    @State private var fromEmptyField: Bool = false
    @State private var timer: Timer?
    
    private var numbers: some View {
        ForEach(1...50, id: \.self) { amount in
            Text(amount, format: .number).tag(amount)
        }
    }
    
    private func generateMaze() {
        if category == .rectangularMaze {
            mazeGenerate = MazeGenerator(rows: rows, cols: columns)
            (mazeGenerate as? MazeGenerator)!.generate()
            (mazeGenerate as? MazeGenerator)!.printMaze()
        } else if category == .caveMaze {
            mazeGenerate = CaveGenerator(rows: rows, cols: columns)
            if fromEmptyField {
                (mazeGenerate as? CaveGenerator)!.initCave()
            } else {
                mazeGenerate?.generate()
            }
        }
        
        mazeData = mazeGenerate!.maze.toMazeData(name: name, category: category)
        isDisabled = false
    }
    
    private func container<Content: View>( @ViewBuilder content: @escaping () -> Content) -> some View {
#if os(iOS)
        Form { content() }
#else
        Form { content()}
            .padding(50)
            .fixedSize()
#endif
    }
    
    var body: some View {
        container {
            Section("Name:") {
                TextField(text: $name) { }
                    .foregroundStyle(isDisabled ? .gray : .accent)
                    .font(.headline)
                    .disabled(isDisabled)
            }
            
            Section("Generate Maze:") {
                Picker("Rows:", selection: $rows) {
                    numbers
                        .padding(.horizontal)
                }
                Picker("Columns:", selection: $columns) {
                    numbers
                        .padding(.horizontal)
                }
            }
            
            if category == .caveMaze {
                Section("Cave configuration:") {
                    Toggle("From Empty Field", isOn: $fromEmptyField)
                    Stepper("Birth limit: \(birthLimit)", value: $birthLimit, in: CaveConfigurations.minNeighbours...CaveConfigurations.maxNeighbours)
                    Stepper("Death limit: \(deathLimit)", value: $deathLimit, in: CaveConfigurations.minNeighbours...CaveConfigurations.maxNeighbours)
                    Toggle("Automatic", isOn: $isAutomatic)
                        .onChange(of: isAutomatic) { _, _ in
                            toggleAutomatic()
                        }
                    
                    if !isAutomatic {
                        Stepper("Delay: \(stepDelay, specifier: "%.1f")с", value: $stepDelay, in: 0.1...5.0, step: 0.1)
                    }
                }
            }

        }
        .onAppear {
            generateMaze()
        }
#if os(macOS)
        .toolbar {
            saveButton
            stepButton
            discardButton
        }
#endif
        .onChange(of: fromEmptyField) { _, _ in
            generateMaze()
        }
        .onChange(of: columns) { _, _ in
            generateMaze()
        }
        .onChange(of: rows) { _, _ in
            generateMaze()
        }
        Group {
            if let mazeData {
                MazeDraw(mazeData: mazeData)
                    .padding()
                    .frame(minWidth: 200, idealWidth: 400, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .center)
            }
#if os(iOS)
            HStack {
                saveButton
                if category == .caveMaze {
                    stepButton
                }
            }
            .padding()
#endif
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func nextStep() {
        let caveGenerator = CaveGenerator(maze: mazeData?.toMaze ?? Maze())
        caveGenerator.oneStep()
        mazeData = caveGenerator.maze.toMazeData(name: name, category: category)
    }
    
    private func toggleAutomatic() {
        if isAutomatic {
            timer = Timer.scheduledTimer(withTimeInterval: stepDelay, repeats: true) { _ in
                nextStep()
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    
    private var discardButton: some View {
        Button("Discard", systemImage: "xmark") {
            dismiss()
        }
    }
    
    private var stepButton: some View {
        Button {
            nextStep()
        } label: {
            Image(systemName: "arrow.forward")
#if os(iOS)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.accentReverse)
                .background(
                    Color.accentColor
                        .clipShape(Capsule())
                )
#endif
        }
        .disabled(isAutomatic)
    }
    
    private var saveButton: some View {
        Button {
            if let mazeData {
                mazeData.name = name
                modelContext.insert(mazeData)
            }
            dismiss()
        } label: {
            Text("Save")
#if os(iOS)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.accentReverse)
                .background(
                    Color.accentColor
                        .clipShape(Capsule())
                )
#endif
        }
        .disabled(isDisabled)
    }
}

#Preview {
    MazeDataGenerate(category: .caveMaze)
}
