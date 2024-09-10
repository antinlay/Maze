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
    @State var maze: Maze
    @State private var showLines = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height, 500)
            let cellWidth = size / Double(maze.horizontalWalls.count)
            let cellHeight = size / Double(maze.verticalWalls.count)
            
            ZStack {
                // Draw left border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: size))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .opacity(showLines ? 1 : .zero)
                    .animation(.linear(duration: 2), value: showLines)
                
                // Draw top border
                Line(from: CGPoint(x: 0, y: 0), to: CGPoint(x: size, y: 0))
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .opacity(showLines ? 1 : .zero)
                    .animation(.linear(duration: 2), value: showLines)
                
                ForEach(maze.horizontalWalls.indices, id: \.self) { i in
                    ForEach(maze.horizontalWalls[i].indices, id: \.self) { j in
                        let index = (i * maze.horizontalWalls[i].count + j) + 2
                        
                        if maze.horizontalWalls[i][j] {
                            Line(from: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i + 1) * cellHeight), to: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i) * cellHeight))
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                .opacity(showLines ? 1 : .zero)
                                .animation(.easeInOut(duration: 1).delay(Double(index) * 0.01), value: showLines)
                        }
                        if maze.verticalWalls[i][j] {
                            Line(from: CGPoint(x: Double(j) * cellWidth, y: Double(i + 1) * cellHeight), to: CGPoint(x: Double(j + 1) * cellWidth, y: Double(i + 1) * cellHeight))
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                .opacity(showLines ? 1 : .zero)
                                .animation(.linear(duration: 1).delay(Double(index + maze.horizontalWalls.count * maze.horizontalWalls[i].count) * 0.01), value: showLines)
                        }
                    }
                }
            }
            .frame(width: size, height: size)
        }
        .padding()
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
