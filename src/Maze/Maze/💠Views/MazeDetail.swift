//
//  MazeDetail.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct MazeDetail: View {
    var maze: MazeRectengular
    var mazeDataModel = MazeDataModel.shared
    
    var body: some View {
        ScrollView {
            ViewThatFits(in: .horizontal) {
                wideDetails
                narrowDetails
            }
            .scenePadding()
        }
        .navigationTitle(maze.name)
        .onDisappear {
            let renderer = ImageRenderer(content: mazeDraw)
            let mazeImage = renderer.uiImage
            maze.imageData = mazeImage?.pngData()
        }
    }
    
    private var wideDetails: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack(alignment: .top) {
                image
                VStack(alignment: .leading) {
                    title.padding(.bottom)
                }
                .padding()
            }
            Divider()
            mazeDraw
                .aspectRatio(contentMode: .fit)

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
            image
            Divider()
            mazeDraw
                .aspectRatio(contentMode: .fit)
        }
    }
    
    private var title: some View {
#if os(macOS)
        Text(maze.name)
            .font(.largeTitle.bold())
#else
        EmptyView()
#endif
    }
    
    private var image: some View {
        MazeImage(maze: maze)
            .clipShape(.rect(cornerRadius: 20))
    }
    
    private var mazeDraw: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height, 500)
            let cellWidth = size / Double(maze.rightWalls.count)
            let cellHeight = size / Double(maze.lowerWalls.count)
            
            Path { path in

                for i in 0..<maze.rightWalls.count {
                    for j in 0..<maze.rightWalls[i].count {
                        if maze.rightWalls[i][j] {
                            path.move(to: CGPoint(x: Double(j) * cellWidth, y: Double(i) * cellHeight))
                            path.addLine(to: CGPoint(x: Double(j) * cellWidth, y: Double(i + 1) * cellHeight))
                        }
                        if maze.lowerWalls[i][j] {
                            path.move(to: CGPoint(x: Double(j) * cellWidth, y: Double(i) * cellHeight))
                            path.addLine(to: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i) * cellHeight))
                        }
                    }
                    if maze.lowerWalls[i].last! {
                        path.move(to: CGPoint(x: geometry.size.width, y: Double(i) * cellHeight))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: Double(i + 1) * cellHeight))
                    }
                }
                if maze.rightWalls.last?.last != true {
                    path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
            }
            .trim(from: 0, to: 1)
            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)

        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        MazeDetail(maze: .mazes.first!)
    }
}
