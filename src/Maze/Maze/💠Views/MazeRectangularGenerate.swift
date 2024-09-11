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
        Button {
            withAnimation {
                maze = generateMaze()
                mazeRectangular = maze.toMazeRectangular
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
        TextField("Name of Maze", text: $mazeRectangular.name)
            .font(.headline)
            .padding(.horizontal)
        MazeDraw(maze: maze)
            .padding()
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
    }
}

#Preview {
    MazeRectangularGenerate()
}
