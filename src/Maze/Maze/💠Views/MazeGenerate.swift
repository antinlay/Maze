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
    @State private var maze = Maze()
    @State private var rows: Int = 10
    @State private var columns: Int = 10
    @State private var isDisabled = true
    
    private var numbers: some View {
        ForEach(1...50, id: \.self) { amount in
            Text(amount, format: .number).tag(amount)
        }
    }
    
    private func generateMaze() {
        let mazeGenerator = MazeGenerator(rows: rows, cols: columns)
        mazeGenerator.generate()
        mazeGenerator.printMaze()
        maze = mazeGenerator.maze
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
            Section("Name:") {
                TextField(text: $name) { }
                    .foregroundStyle(isDisabled ? .gray : .accent)
                    .font(.headline)
                    .disabled(isDisabled)
            }
        }
        .onAppear {
            generateMaze()
        }
#if os(macOS)
        .toolbar {
            saveButton
                .disabled(isDisabled)
            discardButton
        }
#endif
        .onChange(of: columns) { _, _ in
            generateMaze()
        }
        .onChange(of: rows) { _, _ in
            generateMaze()
        }
        Group {
            MazeDraw(maze: maze)
                .padding()
                .frame(minWidth: 200, idealWidth: 400, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .center)
#if os(iOS)
            saveButton
                .disabled(isDisabled)
                .padding()
#endif
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private var discardButton: some View {
        Button("Discard", systemImage: "xmark") {
            dismiss()
        }
    }
    
    private var saveButton: some View {
        Button {
            modelContext.insert(maze.toMazeData(name: name, category: category))
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
    }
}

#Preview {
    MazeDataGenerate(category: .rectangularMaze)
}
