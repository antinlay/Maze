//
//  🎨MazeDraw.swift
//  Maze
//
//  Created by Janiece Eleonour on 10.09.2024.
//

import SwiftUI

struct MazeDraw: View {
    var maze: Maze
    
    @State private var scale: CGFloat = 1.0
    @State private var showLines = false
    @State private var selectedCell: (Double, Double) = (0, 0)
    @State private var isOpen: Bool = false
    @State private var start: CGPoint?
    @State private var end: CGPoint?
    @State private var shortWay: [CGPoint] = []
    
    private func drawingWalls(drawRightWalls: @escaping (_ i: Double, _ j: Double) -> some View,
                              drawLowerWalls: @escaping (_ i: Double, _ j: Double) -> some View,
                              drawTapRectangle: @escaping (_ i: Double, _ j: Double) -> some View) -> some View {
        ForEach(maze.lowerWalls.indices, id: \.self) { i in
            ForEach(maze.lowerWalls[i].indices, id: \.self) { j in
                drawTapRectangle(Double(i), Double(j))
                
                if maze.lowerWalls[i][j] {
                    drawLowerWalls(Double(i), Double(j))
                }
                
                if maze.rightWalls[i][j] {
                    drawRightWalls(Double(i), Double(j))
                }
            }
        }
    }
    
    var body: some View {
        if maze.row != 0, maze.col != 0 {
            GeometryReader { geometry in
                // Get size of view
                let sizeWidth = min(geometry.size.width, 500)
                let sizeHeight = min(geometry.size.height, 500)
                // Find size of cell
                let cellWidth = sizeWidth / Double(maze.col)
                let cellHeight = sizeHeight / Double(maze.row)
                // Calculate points for lines
                let fromRightWall: (_ i: Double, _ j: Double) -> CGPoint = { i, j in
                    CGPoint(x: (j + 1) * cellWidth, y: i * cellHeight)
                }
                let toRightWall: (_ i: Double, _ j: Double) -> CGPoint = { i, j in
                    CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight)
                }
                let fromLowerWall: (_ i: Double, _ j: Double) -> CGPoint = { i, j in
                    CGPoint(x: j * cellWidth, y: (i + 1) * cellHeight)
                }
                let toLowerWall: (_ i: Double, _ j: Double) -> CGPoint = { i, j in
                    CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight)
                }
                // Line style
                let strokeStyle = StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
                
                // Draw left border
                Line(from: .zero, to: CGPoint(x: 0, y: sizeHeight))
                    .stroke(.accent, style: strokeStyle)
                // Draw top border
                Line(from: .zero, to: CGPoint(x: sizeWidth, y: 0))
                    .stroke(.accent, style: strokeStyle)
                // Draw right walls
                drawingWalls { i, j in
                    Line(from: fromRightWall(i, j), to: toRightWall(i, j))
                        .stroke(.accent, style: strokeStyle)
                } drawLowerWalls: { i, j in
                    Line(from: fromLowerWall(i, j), to: toLowerWall(i, j))
                        .stroke(.accent, style: strokeStyle)
                } drawTapRectangle: { i, j in
                    TapRectangle(start: $start, end: $end, shortWay: $shortWay, maze: maze, id: CGPoint(x: j, y: i))
                        .frame(width: cellWidth * 0.5, height: cellHeight * 0.5)
                        .position(x: (j + 0.5) * cellWidth, y: (i + 0.5) * cellHeight)
                }
                
                ForEach(shortWay.indices, id: \.self) { index in
                    if index != shortWay.count - 1 {
                        Line(from: CGPoint(x: shortWay[index].x * cellWidth, y: shortWay[index].y * cellHeight),
                             to: CGPoint(x: shortWay[index + 1].x * cellWidth, y: shortWay[index + 1].y * cellHeight))
                        .stroke(.path, lineWidth: 2)
                    }
                }
            }
            .opacity(showLines ? 1 : .zero)
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = value.magnitude
                    }
                    .onEnded { _ in
                        scale = 1
                    }
            )
            .onAppear {
                withAnimation {
                    showLines = true
                }
            }
        }
    }
}

#Preview {
    MazeDraw(maze: Maze(lowerWalls: MazeRectangular.mazes.first!.lowerWalls, rightWalls: MazeRectangular.mazes.first!.rightWalls))
}
