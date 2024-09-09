//
//  MazeDetail.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct MazeDetail: View {
    var maze: Maze
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
            .frame(width: 300, height: 300)
            .clipShape(.rect(cornerRadius: 20))
    }
    
    private var mazeDraw: some View {
        GeometryReader { geometry in
            Path { path in
                let cellWidth = geometry.size.width / CGFloat(maze.rightWalls.count)
                let cellHeight = geometry.size.height / CGFloat(maze.lowerWalls.count)
                
                for i in 0..<maze.rightWalls.count {
                    for j in 0..<maze.rightWalls[i].count {
                        if maze.rightWalls[i][j] {
                            path.move(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i) * cellHeight))
                            path.addLine(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i + 1) * cellHeight))
                        }
                        if maze.lowerWalls[i][j] {
                            path.move(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i) * cellHeight))
                            path.addLine(to: CGPoint(x: CGFloat(j + 1) * cellWidth, y: CGFloat(i) * cellHeight))
                        }
                    }
                    if maze.lowerWalls[i].last! {
                        path.move(to: CGPoint(x: geometry.size.width, y: CGFloat(i) * cellHeight))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: CGFloat(i + 1) * cellHeight))
                    }
                }
                if maze.rightWalls.last?.last != true {
                    path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
            }
            .stroke(Color.accentColor, lineWidth: 2)
        }
        .padding()
    }
    
    
}

#Preview {
    NavigationStack {
        MazeDetail(maze: .mazes.first!)
    }
}
