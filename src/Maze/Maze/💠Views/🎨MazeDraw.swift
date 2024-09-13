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
    
    private func drawingWalls(walls: [[Bool]], action: @escaping (_ i: Double, _ j: Double) -> some View) -> some View {
        ForEach(walls.indices, id: \.self) { i in
            ForEach(walls[i].indices, id: \.self) { j in
                let isWall = walls[i][j]
                
                if isWall {
                    action(Double(i), Double(j))
                }
            }
        }
    }
    
    var body: some View {
        if maze.row != 0, maze.col != 0 {
            GeometryReader { geometry in
                let sizeWidth = min(geometry.size.width, 500)
                let sizeHeight = min(geometry.size.height, 500)
                let cellWidth = sizeWidth / Double(maze.col)
                let cellHeight = sizeHeight / Double(maze.row)
                
                // Draw left border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: sizeHeight))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                // Draw top border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: sizeWidth, y: 0))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                // Draw horizontal
                drawingWalls(walls: maze.horizontalWalls) { i, j in
                    Line(from: CGPoint(x: j * cellWidth, y: (i + 1) * cellHeight), to: CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight))
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
                // Draw vertical
                drawingWalls(walls: maze.verticalWalls) { i, j in
                    Line(from: CGPoint(x: (j + 1) * cellWidth, y: i * cellHeight), to: CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight))
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }

            }
            .opacity(showLines ? 1 : .zero)
            .onAppear {
                withAnimation {
                    showLines = true
                }
            }
        }
    }
}

#Preview {
    MazeDraw(maze: Maze(horizontalWalls: MazeRectangular.mazes.first!.rightWalls, verticalWalls: MazeRectangular.mazes.first!.lowerWalls))
}
