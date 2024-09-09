//
//  MazeDataModel.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftData

@Observable final class MazeDataModel {
    private var mazes: [Maze] = []
    private var mazesByID: [Maze.ID: Maze]? = nil

    static let shared: MazeDataModel = MazeDataModel()

    private init() {
        mazes = Maze.mazes
    }

    func mazes(in category: MazeCategory?) -> [Maze] {
        mazes
            .filter { $0.category == category }
            .sorted { $0.name < $1.name }
    }

    subscript(mazeID: Maze.ID?) -> Maze? {
        guard let mazeID else { return nil }
        if mazesByID == nil {
            mazesByID = Dictionary(
                uniqueKeysWithValues: mazes.map { ($0.id, $0) })
        }
        return mazesByID![mazeID]
    }

    var mazeOfTheDay: Maze {
        mazes[0]
    }
}
