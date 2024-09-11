//
//  📝MazeEdit.swift
//  Maze
//
//  Created by Janiece Eleonour on 11.09.2024.
//

import SwiftUI
import PhotosUI
import SwiftData

struct MazeEdit: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var maze: MazeRectangular
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var text = ""
    @State private var error: Error?
    @State private var isImporting = false
    
    
    private var importButton: some View {
        Button {
            isImporting = true
        } label: {
            Label("Import file",
                  systemImage: "square.and.arrow.down")
        }
    }
    
    private var imagePicker: some View {
        // Change photo button
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
#if os(iOS)
            // Display the current image
            MazeImage(maze: maze)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal)
#else
            Text("Change image")
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
        ScrollView(.horizontal) {
            ForEach(walls.wrappedValue.indices, id: \.self) { row in
                HStack {
                    ForEach(walls.wrappedValue[row].indices, id: \.self) { column in
                        Toggle(isOn: Binding<Bool>(
                            get: { walls.wrappedValue[row][column] },
                            set: { walls.wrappedValue[row][column] = $0 }
                        )) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Text("Edit: \(maze.name)")
                .font(.headline)
                .padding(.bottom)
#if os(macOS)
            MazeImage(maze: maze)
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal)
#endif
            imagePicker
            Divider()
            
            //            ScrollView(.horizontal, showsIndicators: false) {
            // Display and edit right walls
            Text("Right Walls")
                .font(.headline)
            changeWalls(walls: $maze.rightWalls)
            Divider()
            // Display and edit lower walls
            Text("Lower Walls")
                .font(.headline)
            changeWalls(walls: $maze.lowerWalls)
            Divider()
            //            }
                .padding(10)
        }
        .toolbar {
            importButton
        }
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.text]) {
            let result = $0.flatMap { url in
                read(from: url)
            }
            switch result {
            case .success(let text):
                self.text += text
            case .failure(let error):
                self.error = error
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
