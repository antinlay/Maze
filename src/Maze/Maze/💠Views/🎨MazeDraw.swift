//
//  🎨MazeDraw.swift
//  Maze
//
//  Created by Janiece Eleonour on 10.09.2024.
//

import SwiftUI

struct Coordinate: Hashable {
    let x: Double
    let y: Double
}


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

struct TapRectangle: View {
    var id: Coordinate
    var isOpen: Bool
    
    var body: some View {
        Rectangle()
            .fill(isOpen ? Color.blue : Color.clear)
            .contentShape(Rectangle())
    }
}
struct MazeDraw: View {
    var maze: Maze
    @State private var showLines = false
    @State private var selectedCell: (Double, Double) = (0, 0)
    @State private var isOpen: Bool = false
    @State private var start: Coordinate?
    @State private var end: Coordinate?
    
    
    private func drawingWalls(drawRightWalls: @escaping (_ i: Double, _ j: Double) -> some View,
                              drawLowerWalls: @escaping (_ i: Double, _ j: Double) -> some View,
                              drawTapRectangle: @escaping (_ i: Double, _ j: Double) -> some View) -> some View {
        ForEach(maze.horizontalWalls.indices, id: \.self) { i in
            ForEach(maze.horizontalWalls[i].indices, id: \.self) { j in
                drawTapRectangle(Double(i), Double(j))
                
                if maze.horizontalWalls[i][j] {
                    drawLowerWalls(Double(i), Double(j))
                }
                
                if maze.verticalWalls[i][j] {
                    drawRightWalls(Double(i), Double(j))
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
                drawingWalls { i, j in
                    Line(from: CGPoint(x: (j + 1) * cellWidth, y: i * cellHeight), to: CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight))
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                } drawLowerWalls: { i, j in
                    Line(from: CGPoint(x: j * cellWidth, y: (i + 1) * cellHeight), to: CGPoint(x: (j + 1) * cellWidth, y: (i + 1) * cellHeight))
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                } drawTapRectangle: { i, j in
                    TapRectangle(id: Coordinate(x: i, y: j), isOpen: Coordinate(x: i, y: j) == start || Coordinate(x: i, y: j) == end)
                        .onTapGesture {
                            withAnimation {
                                if start == nil {
                                    start = Coordinate(x: i, y: j)
                                } else if end == nil {
                                    end = Coordinate(x: i, y: j)
                                } else {
                                    start = nil
                                    end = nil
                                }
                            }
                        }
                        .frame(width: cellWidth, height: cellHeight)
                        .position(x: (j + 0.5) * cellWidth, y: (i + 0.5) * cellHeight)
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
