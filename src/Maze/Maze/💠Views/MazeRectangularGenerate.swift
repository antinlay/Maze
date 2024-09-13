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
    @State private var isImporting = false
    @State private var error: Error?
    @State private var text = ""
    
    private var numbers: some View {
        ForEach(1...50, id: \.self) { amount in
            Text(amount, format: .number)
        }
    }
    
    private func generateMaze() -> Maze {
        let mazeGenerator = MazeGenerator(rows: rows, cols: columns)
        mazeGenerator.generate()
        mazeGenerator.printMaze()
        return mazeGenerator.maze
    }
    
    var body: some View {
        importButton
            .padding()
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

        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.text]) {
            let result = $0.flatMap { url in
                read(from: url)
            }
            switch result {
            case .success(let strings):
                text += strings
                
                let parseResult = ParseMazeFiles(str: text).parse()
                
                switch parseResult {
                case .success(let success):
                    maze = success
                    mazeRectangular = maze.toMazeRectangular
                    isDisabled = false
                case .failure(let failure):
                    error = failure
                }
            case .failure(let failure):
                self.error = failure
            }
        }

    }
    
    private var importButton: some View {
        Button {
            isImporting = true
        } label: {
            Label("Import file", systemImage: "square.and.arrow.down")
        }
    }

    private func read(from url: URL) -> Result<String,Error> {
        let accessing = url.startAccessingSecurityScopedResource()
        defer {
            if accessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        
        return Result { try String(contentsOf: url) }
    }

}

#Preview {
    MazeRectangularGenerate()
}
