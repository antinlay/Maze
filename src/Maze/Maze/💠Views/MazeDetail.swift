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
            NavigationLink("Edit") {
                MazeEdit(maze: mazeRectangular)
            }
        }
//        .onDisappear {
//            render()
//        }
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
                    if let imageData = mazeRectangular.imageData {
                        Image(data: imageData)
                    }
                }
                .padding()
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
}

#Preview {
    NavigationStack {
        MazeDetail(mazeRectangular: .mazes.first!)
    }
}
