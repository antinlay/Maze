//
//  📝MazeEdit.swift
//  Maze
//
//  Created by Janiece Eleonour on 11.09.2024.
//

import SwiftUI
import PhotosUI
import SwiftData

enum ImportErrorSaver: LocalizedError {
    case parseError(String)
    case fileNotFound(String)
    case invalidData(String)
    
    var errorDescription: String? {
        switch self {
        case .parseError(let message):
            "Parse error: \(message)"
        case .fileNotFound(let fileName):
            "File not found: \(fileName)"
        case .invalidData(let message):
            "Invalid data: \(message)"
        }
    }
}

struct MazeEdit: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var maze: MazeRectangular
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var text = ""
    @State private var error: ImportErrorSaver? = nil
    @State private var isImporting = false
    @State private var showAlert = false
    
    
    private var importButton: some View {
        Button {
            isImporting = true
        } label: {
            Label("Import file", systemImage: "square.and.arrow.down")
        }
    }
    
    private var imagePicker: some View {
        // Change photo button
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
#if os(macOS)
            Text("Change image")
#else
            // Display the current image
            MazeImage(maze: maze)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal)
#endif
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                // Retrieve selected asset in the form of Data
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    maze.imageData = data
                }
            }
        }
    }
    
    private func changeWalls(walls: Binding<[[Bool]]>) -> some View {
        ScrollView([.horizontal, .vertical]) {
            ForEach(walls.wrappedValue.indices, id: \.self) { row in
                HStack {
                    ForEach(walls.wrappedValue[row].indices, id: \.self) { column in
                        Toggle(isOn: Binding<Bool>(
                            get: { walls.wrappedValue[row][column] },
                            set: { walls.wrappedValue[row][column] = $0 }
                        )) {
                            VStack(alignment: .leading) {
                                Text(String(format: "%02d", row))
                                Text(String(format: "%02d", column))
                            }
                            .font(.system(size: 8))
                            .fontWidth(.compressed)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        Form {
            Section("Name:") {
                TextField(text: $maze.name) {
                    //
                }
                .font(.headline)
            }
            Section("Image:") {
                imagePicker
            }
            // Display and edit right walls
            Section("Right Walls") {
                changeWalls(walls: $maze.rightWalls)
            }
            // Display and edit lower walls
            Section("Lower Walls") {
                changeWalls(walls: $maze.lowerWalls)
            }
            .padding(10)
        }
        .toolbar {
            importButton
        }
        .alert(isPresented: $showAlert, error: error) { _ in
            Button("OK") {
                showAlert = false
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "Try again later.")
        }
        .onDisappear {
            try? modelContext.save()
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
                    maze.rightWalls = success.verticalWalls
                    maze.lowerWalls = success.horizontalWalls
                case .failure(let failure):
                    error = .parseError(failure.localizedDescription)
                }
                
            case .failure(let failure):
                error = .invalidData(failure.localizedDescription)
            }
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
    MazeEdit(maze: .mazes.first!)
}
