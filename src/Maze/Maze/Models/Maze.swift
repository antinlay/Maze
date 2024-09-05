//
//  Maze.swift
//  Maze
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftUI

struct Maze: Identifiable {
    let id = UUID()
    let name: String
    let category: MazeCategory
    let rows: Int
    let columns: Int
    let rightWalls: [[Bool]]
    let lowerWalls: [[Bool]]
}

extension Maze {
    static let mazes = [
        Maze(name: "Maze 1", category: .rectangularMaze, rows: 10, columns: 10, rightWalls: [
            [false, false, true, false, false, false, false, true, false, true],
            [false, true, true, true, false, false, false, true, true, true],
            [true, false, true, false, false, true, true, true, true, true],
            [true, false, false, true, false, false, true, false, true, true],
            [false, false, true, false, true, false, true, false, true, true],
            [true, false, false, false, false, true, true, false, true, true],
            [false, false, false, true, true, false, false, true, false, true],
            [false, false, false, false, true, false, true, true, false, true],
            [true, false, false, false, true, true, true, false, false, true],
            [false, true, false, true, false, true, false, false, false, true]
        ], lowerWalls: [
            [false, true, false, false, false, true, true, true, false, false],
            [true, true, false, false, true, true, true, false, false, false],
            [false, false, true, true, true, false, false, false, false, false],
            [false, true, true, false, false, true, false, false, true, false],
            [true, false, true, true, false, false, true, true, true, false],
            [false, true, true, true, false, true, false, false, false, false],
            [true, true, false, true, true, false, false, true, false, true],
            [false, true, true, true, true, false, false, false, true, false],
            [true, false, true, false, false, false, false, true, true, true],
            [true, true, true, true, true, true, true, true, true, true]
        ]),
        Maze(name: "Cave 1", category: .rectangularMaze, rows: 10, columns: 10, rightWalls: [
            [true, false, false, true, false, true, false, false, true, false],
            [true, true, true, false, false, false, false, false, false, false],
            [false, false, false, true, true, true, false, true, false, false],
            [false, false, true, true, true, true, false, false, false, false],
            [false, false, false, true, false, true, true, false, false, false],
            [false, true, true, false, true, false, true, true, true, false],
            [true, true, false, false, false, true, true, false, false, true],
            [false, true, true, true, true, false, false, false, true, false],
            [false, false, true, false, false, false, false, true, true, true],
            [true, true, true, false, true, true, false, false, false, true]
        ], lowerWalls: [
            [false, false, false, true, false, false, false, false, true, false],
            [false, false, true, false, false, true, true, true, false, false],
            [false, false, false, true, true, true, false, false, false, false],
            [false, false, true, true, true, true, false, false, true, false],
            [false, false, false, true, false, false, true, true, false, false],
            [true, false, true, true, false, true, false, false, false, false],
            [true, true, false, false, true, false, true, false, true, true],
            [false, true, true, true, true, false, false, false, true, false],
            [false, false, true, false, true, true, true, false, false, true],
            [true, true, true, true, true, true, true, true, true, true]
        ]),
        Maze(name: "Maze 2", category: .rectangularMaze, rows: 20, columns: 20, rightWalls: [
            [false, false, false, false, true, false, true, false, false, true, false, false, false, false, false, false, false, false, false, true],
            [false, false, false, true, true, true, false, true, false, false, true, true, false, false, true, false, true, true, false, true],
            [true, false, false, true, false, false, false, false, false, false, true, true, false, true, false, true, true, true, true, true],
            [true, true, false, false, false, false, false, false, true, false, true, false, true, false, true, false, true, true, true, true],
            [true, true, false, false, false, false, false, false, true, true, false, false, false, false, true, false, false, true, true, true],
            [false, true, false, true, false, false, false, false, true, true, false, false, false, false, false, false, false, false, false, true],
            [true, false, false, true, false, false, false, false, false, true, false, false, true, false, false, false, false, false, false, true],
            [false, false, false, true, true, false, true, false, true, false, false, false, true, true, false, false, false, false, false, true],
            [true, false, true, true, true, true, true, true, true, false, false, false, true, true, true, true, false, false, false, true],
            [true, true, false, true, true, true, true, false, true, true, false, false, true, true, false, false, false, false, false, true],
            [false, false, true, false, true, false, true, false, false, true, false, false, true, true, false, true, false, true, false, true],
            [false, false, true, false, true, true, false, true, false, false, true, true, true, true, true, true, true, false, true, true],
            [false, false, false, false, false, false, false, false, false, true, true, false, true, true, false, false, true, true, true, true],
            [true, false, true, false, false, false, false, true, true, true, false, false, true, true, false, false, true, true, true, true],
            [true, true, true, false, false, false, false, true, true, true, false, false, true, true, false, true, false, true, false, true],
            [true, true, false, false, false, false, true, true, true, true, false, false, true, true, true, false, true, false, true, true],
            [true, true, true, false, false, true, true, true, true, true, false, false, true, true, false, false, false, false, true, true],
            [true, true, true, false, true, true, true, true, true, true, false, false, true, true, false, false, false, false, true, true],
            [true, true, true, false, true, false, true, true, true, true, false, false, true, false, false, false, false, false, false, true],
            [true, true, true, false, true, true, true, false, true, false, true, true, false, false, false, false, false, false, false, true]
        ], lowerWalls: [
            [false, true, true, true, false, false, false, true, false, false, true, false, false, true, true, true, true, false, true, false],
            [false, true, true, false, false, true, true, true, false, true, true, false, false, true, false, false, false, false, false, false],
            [false, false, false, true, true, true, true, true, true, true, false, false, true, false, true, false, false, false, false, false],
            [false, false, true, true, true, true, true, true, false, false, true, true, false, true, false, false, false, false, false, false],
            [false, false, false, true, true, true, true, true, false, false, true, true, true, true, true, false, false, false, false, false],
            [true, false, true, false, true, true, true, true, true, false, false, true, true, true, true, true, true, true, true, true],
            [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false],
            [false, true, true, false, false, false, false, false, false, true, true, true, false, false, false, true, true, true, true, false],
            [false, false, false, false, false, false, false, false, false, false, true, false, true, false, false, false, true, true, true, false],
            [true, false, true, false, true, true, true, false, true, true, false, false, true, false, false, false, false, false, true, false],
            [true, true, false, true, false, false, true, false, false, true, false, false, true, true, false, false, true, true, false, false],
            [true, true, true, true, true, false, true, true, false, false, true, true, true, true, true, true, true, false, true, false],
            [false, true, true, true, true, true, true, true, false, false, true, true, false, false, false, true, true, true, true, false],
            [false, false, false, true, true, true, true, true, false, false, false, true, true, false, true, true, true, true, true, true],
            [false, false, false, true, true, true, true, true, true, false, false, true, true, false, false, false, false, false, false, false],
            [false, false, false, true, true, true, true, true, true, true, false, false, true, false, false, true, false, true, false, false],
            [false, false, false, true, true, true, true, true, true, true, false, false, true, true, true, false, false, false, false, false],
            [false, false, false, true, true, true, true, true, true, true, false, false, true, true, false, false, false, false, true, false],
            [false, false, false, true, true, true, true, true, true, true, false, false, true, false, false, false, false, false, false, false],
            [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
        ])
    ]

}
