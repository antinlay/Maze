//
//  🎨MazeDraw.swift
//  Maze
//
//  Created by Janiece Eleonour on 10.09.2024.
//

import SwiftUI

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }
}

struct MazeDraw: View {
    var maze: Maze
    @State private var showLines = false
    
    var body: some View {
        GeometryReader { geometry in
            let sizeWidth = min(geometry.size.width, 500)
            let sizeHeight = min(geometry.size.height, 500)
            let cellWidth = sizeWidth / Double(maze.horizontalWalls.count)
            let cellHeight = sizeHeight / Double(maze.verticalWalls.count)
            
            ZStack {
                // Draw left border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: sizeHeight))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                // Draw top border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: sizeWidth, y: 0))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // Draw right border
                Line(from: CGPoint(x: sizeWidth, y: 0), to: CGPoint(x: sizeWidth, y: sizeHeight))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // Draw bottom border
                Line(from: CGPoint(x: 0, y: sizeHeight), to: CGPoint(x: sizeWidth, y: sizeHeight))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

                
                ForEach(maze.horizontalWalls.indices, id: \.self) { i in
                    ForEach(maze.horizontalWalls[i].indices, id: \.self) { j in
                        if maze.horizontalWalls[i][j] {
                            Line(from: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i + 1) * cellHeight), to: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i) * cellHeight))
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        }
                        
                        if maze.verticalWalls[i][j] {
                            Line(from: CGPoint(x: Double(j) * cellWidth, y: Double(i + 1) * cellHeight), to: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i + 1) * cellHeight))
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        }
                    }
                }
            }
//            .frame(width: size, height: size)
        }
        .opacity(showLines ? 1 : .zero)
        .onAppear {
            withAnimation {
                showLines = true
            }
        }
    }
}

#Preview {
    MazeDraw(maze: Maze(horizontalWalls: MazeRectangular.mazes.first!.rightWalls, verticalWalls: MazeRectangular.mazes.first!.lowerWalls))
}
