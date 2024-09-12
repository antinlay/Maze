//
//  MazeRectangularGenerate.swift
//  Maze
//
//  Created by Janiece Eleonour on 11.09.2024.
//

import SwiftUI

struct MazeRectangularGenerate: View {
    @Environment(\.modelContext) private var modelContext
    @State private var mazeRectangular = Maze().toMazeRectangular
    @State private var maze = Maze()
    @State private var rows: Int = 10
    @State private var columns: Int = 10
    @State private var isDisabled = true
    
    private var numbers: some View {
        ForEach(1...50, id: \.self) { amount in
            Text(amount, format: .number)
        }
    }
    
    private func generateMaze() -> Maze {
        let mazeGenerator = MazeGenerator(rows: rows, cols: columns)
        mazeGenerator.generate()
        return mazeGenerator.maze
    }
    
    var body: some View {
        List {
            Picker("Rows", selection: $rows) {
                numbers
            }
            .pickerStyle(.menu)
            Picker("Columns", selection: $columns) {
                numbers
            }
        }
        .padding(.bottom)
        
        HStack {
            Text("Name:")
            TextField("Name of Maze", text: $mazeRectangular.name, prompt: Text("Enter name"))
                .textFieldStyle(.roundedBorder)
        }
        .foregroundStyle(isDisabled ? .gray : .black)
        .font(.headline)
        .disabled(isDisabled)
            .padding(.horizontal)
        MazeDraw(maze: maze)
            .padding()
        HStack {
            Button {
                withAnimation {
                    maze = generateMaze()
                    mazeRectangular = maze.toMazeRectangular
                    isDisabled = false
                }
            } label: {
                Text("Generate Maze")
                    .foregroundStyle(.accentReverse)
                    .padding()
                    .background(
                        Color.accentColor
                            .clipShape(Capsule())
                    )
            }

            Button {
                modelContext.insert(mazeRectangular)
            } label: {
                Text("Save Maze")
                    .foregroundStyle(.accentReverse)
                    .padding()
                    .background(
                        Color.accentColor
                            .clipShape(Capsule())
                    )
            }
            .disabled(isDisabled)
        }
    }
}

#Preview {
    MazeRectangularGenerate()
}
