//
//  MazeRectengular.swift
//  MazeRectengular
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftData
import SwiftUI

@Model
class MazeRectengular: Identifiable {
    let id: UUID
    var name: String
    var imageData: Data?
    let category: MazeCategory
    let rows: Int
    let columns: Int
    let rightWalls: [[Bool]]
    let lowerWalls: [[Bool]]
    
    init(id: UUID = UUID(), name: String, imageData: Data? = nil, category: MazeCategory, rows: Int, columns: Int, rightWalls: [[Bool]], lowerWalls: [[Bool]]) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.category = category
        self.rows = rows
        self.columns = columns
        self.rightWalls = rightWalls
        self.lowerWalls = lowerWalls
    }
}

extension MazeRectengular {
    static let mazes = [
        MazeRectengular(name: "MazeRectengular 1", category: .rectangularMaze, rows: 10, columns: 10, rightWalls: [
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
        MazeRectengular(name: "Cave 1", category: .rectangularMaze, rows: 10, columns: 10, rightWalls: [
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
        MazeRectengular(name: "MazeRectengular 2", category: .rectangularMaze, rows: 20, columns: 20, rightWalls: [
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
