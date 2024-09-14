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
    @State private var isExporting = false
    @State private var error: Error?
    @State private var text = ""
    @State private var textDocument: TextFile?
    
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
        mazeRectangular = maze.toMazeRectangular
        withAnimation {
            isDisabled = false
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            importButton
                .padding()
            HStack {
                Spacer()
                Form {
                    Picker("Rows:", selection: $rows) {
                        numbers
                            .padding(.horizontal)
                    }
                    
                    Picker("Columns:", selection: $columns) {
                        numbers
                            .padding(.horizontal)
                    }
                    TextField("Name:", text: $mazeRectangular.name, prompt: Text("Enter name"))
                        .foregroundStyle(isDisabled ? .gray : .accent)
                        .font(.headline)
                        .disabled(isDisabled)
                    
                    MazeDraw(maze: maze)
                        .padding()
                        .frame(minWidth: 200, idealWidth: 400, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity, alignment: .center)
                    
                }
                
            }
            .onChange(of: columns) { _, _ in
                generateMaze()
            }
            .onChange(of: rows) { _, _ in
                generateMaze()
            }
            
            HStack {
                exportButton
                Spacer()
                saveButton
            }
            .padding()
            .disabled(isDisabled)
            Spacer()
        }
        .onAppear {
            generateMaze()
        }
        .fileExporter(isPresented: $isExporting, document: textDocument, contentType: .plainText) { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let error):
                print(error.localizedDescription)
            }
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
    
    private var saveButton: some View {
        Button {
            modelContext.insert(mazeRectangular)
        } label: {
            Text("Save")
#if os(iOS)
                .padding()
                .foregroundStyle(.accentReverse)
                .background(
                    Color.accentColor
                        .clipShape(Capsule())
                )
#endif
        }
    }
    
    private var exportButton: some View {
        Button {
            text = maze.parseMazeToText()
            print(text)
            textDocument = TextFile(initialText: text)
            isExporting = true
        } label: {
            Text("Export")
#if os(iOS)
                .padding()
                .foregroundStyle(.accentReverse)
                .background(
                    Color.accentColor
                        .clipShape(Capsule())
                )
#endif
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
