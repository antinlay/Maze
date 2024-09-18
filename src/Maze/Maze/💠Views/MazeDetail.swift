//
//  MazeDetail.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct MazeDetail: View {
    @Environment(\.displayScale) var displayScale
    var mazeRectangular: MazeRectangular
    
    @State private var isExporting = false
    @State private var exportText = ""
    @State private var textDocument: TextFile?
    @State private var error: ImportErrorSaver? = nil
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            ViewThatFits(in: .horizontal) {
                wideDetails
                narrowDetails
            }
            .scenePadding()
        }
        .navigationTitle(mazeRectangular.name)
        .toolbar {
            exportButton
            NavigationLink("Edit") {
                MazeEdit(maze: mazeRectangular)
            }
        }
        .fileExporter(isPresented: $isExporting, document: textDocument, contentType: .plainText) { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let err):
                error = .parseError(err.localizedDescription)
            }
            
            exportText = ""
        }
    }
    
    @MainActor func render() {
        let renderer = ImageRenderer(content: MazeDraw(maze: mazeRectangular.toMaze))

        // make sure and use the correct display scale for this device
        renderer.scale = displayScale
#if os(iOS)
        if let uiImage = renderer.uiImage {
            mazeRectangular.imageData = uiImage.pngData()
        }
#else
        if let nsImage = renderer.nsImage {
            mazeRectangular.imageData = nsImage.tiffRepresentation
        }
#endif
    }
    
    private var wideDetails: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    title.padding(.bottom)
                    Text("Rows: ") + Text(mazeRectangular.toMaze.row, format: .number)
                    Text("Columns: ") + Text(mazeRectangular.toMaze.col, format: .number)
                }
                .padding(.horizontal)
            }
            MazeDraw(maze: mazeRectangular.toMaze)
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }
    
    private var narrowDetails: some View {
        let alignment: HorizontalAlignment
#if os(macOS)
        alignment = .leading
#else
        alignment = .center
#endif
        return VStack(alignment: alignment, spacing: 22) {
            title
            MazeDraw(maze: mazeRectangular.toMaze)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    private var title: some View {
#if os(macOS)
        Text(mazeRectangular.name)
            .font(.largeTitle.bold())
#else
        EmptyView()
#endif
    }
    
    private var exportButton: some View {
        Button {
            exportText = mazeRectangular.toMaze.parseMazeToText()
            print(exportText)
            textDocument = TextFile(initialText: exportText)
            isExporting = true
        } label: {
            Label("Export", systemImage: "square.and.arrow.up")
        }
    }

}

#Preview {
    NavigationStack {
        MazeDetail(mazeRectangular: .mazes.first!)
    }
}
