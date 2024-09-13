//
//  MazeRectangular.swift
//  MazeRectangular
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftData
import SwiftUI


@Model
class MazeRectangular: Identifiable {
    let id: UUID
    var name: String
    var imageData: Data?
    let category: MazeCategory
    var rightWalls: [[Bool]]
    var lowerWalls: [[Bool]]
    
    init(id: UUID = UUID(), name: String, imageData: Data? = nil, category: MazeCategory, rightWalls: [[Bool]], lowerWalls: [[Bool]]) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.category = category
        self.rightWalls = rightWalls
        self.lowerWalls = lowerWalls
    }
}

extension [MazeRectangular] {
    subscript(mazeID: MazeRectangular.ID?) -> MazeRectangular? {
        guard let mazeID else { return nil }
        var mazesByID: [MazeRectangular.ID: MazeRectangular]? = nil
        if mazesByID == nil {
            mazesByID = Dictionary(
                uniqueKeysWithValues: self.map { ($0.id, $0) })
        }
        return mazesByID![mazeID]
    }
}

extension MazeRectangular {
    var toMaze: Maze {
        Maze(horizontalWalls: lowerWalls, verticalWalls: rightWalls)
    }
}

extension Maze {
    var toMazeRectangular: MazeRectangular {
        MazeRectangular(name: Date.now.description,
                        category: .rectangularMaze,
                        rightWalls: verticalWalls,
                        lowerWalls: horizontalWalls)
    }
}

extension MazeRectangular {
    static let mazes = [
        MazeRectangular(name: "MazeRectangular 1", category: .rectangularMaze, rightWalls: [
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
            [true, false, true, true, true, false, true, true, true, false],
            [false, true, true, true, false, true, false, false, false, false],
            [true, true, false, true, false, false, true, false, true, true],
            [false, true, true, true, true, false, false, false, true, false],
            [true, false, true, false, false, false, false, true, true, true],
            [true, true, true, true, true, true, true, true, true, true]
        ]),
        MazeRectangular(name: "MazeRectangular 2", category: .rectangularMaze, rightWalls: [
            [true, true, false, false, false, false, true, false, false, true],
            [false, true, false, true, true, true, true, true, true, true],
            [true, false, false, true, false, true, true, false, true, true],
            [true, true, true, false, false, false, true, true, false, true],
            [false, true, false, true, false, false, true, false, true, true],
            [true, false, true, false, true, false, false, true, true, true],
            [true, false, true, true, true, false, false, true, false, true],
            [false, false, false, false, false, true, false, true, true, true],
            [true, true, false, false, true, false, false, true, false, true],
            [false, false, false, true, false, false, false, false, false, true]
        ], lowerWalls: [
            [false, false, false, true, false, true, false, false, true, false],
            [false, true, true, false, false, false, false, false, false, false],
            [false, false, false, true, true, true, false, true, false, false],
            [false, false, true, true, true, true, false, false, false, false],
            [false, false, false, true, false, true, true, false, false, false],
            [false, true, true, false, true, false, true, true, true, false],
            [true, true, false, false, false, true, true, false, false, true],
            [false, true, true, true, true, false, true, false, false, false],
            [false, false, true, true, false, true, true, true, true, false],
            [true, true, true, true, true, true, true, true, true, true]
        ]),
        MazeRectangular(name: "MazeRectangular 3", category: .rectangularMaze, rightWalls: [
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
