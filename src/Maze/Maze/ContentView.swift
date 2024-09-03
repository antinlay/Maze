//
//  ContentView.swift
//  Maze
//
//  Created by Janiece Eleonour on 03.09.2024.
//

import SwiftUI

struct ContentView: View {
    let horizontalWalls: [[Bool]] = [
        [false, false, false, true],
        [true, false, true, true],
        [false, true, false, true],
        [false, false, false, true]
    ]
    let verticalWalls: [[Bool]] = [[false, true, false, true],
        [false, false, true, false],
        [true, true, false, true],
        [true, true, true, true]]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let cellWidth = geometry.size.width / CGFloat(horizontalWalls.count)
                let cellHeight = geometry.size.height / CGFloat(verticalWalls.count)

                for i in 0..<horizontalWalls.count {
                    for j in 0..<horizontalWalls[i].count {
                        if horizontalWalls[i][j] {
                            path.move(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i) * cellHeight))
                            path.addLine(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i + 1) * cellHeight))
                        }
                        if verticalWalls[i][j] {
                            path.move(to: CGPoint(x: CGFloat(j) * cellWidth, y: CGFloat(i) * cellHeight))
                            path.addLine(to: CGPoint(x: CGFloat(j + 1) * cellWidth, y: CGFloat(i) * cellHeight))
                        }
                    }
                    if verticalWalls[i].last! {
                        path.move(to: CGPoint(x: geometry.size.width, y: CGFloat(i) * cellHeight))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: CGFloat(i + 1) * cellHeight))
                    }
                }
                if horizontalWalls.last?.last != true {
                    path.move(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
            }
            .stroke(Color.black, lineWidth: 2)
        }
    }
}

#Preview {
    ContentView()
}
