//
//  MazeDataModel.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftData

@Observable final class MazeDataModel {
    private var mazes: [MazeRectengular] = []
    private var mazesByID: [MazeRectengular.ID: MazeRectengular]? = nil

    static let shared: MazeDataModel = MazeDataModel()

    private init() {
        mazes = MazeRectengular.mazes
    }

    func mazes(in category: MazeCategory?) -> [MazeRectengular] {
        mazes
            .filter { $0.category == category }
            .sorted { $0.name < $1.name }
    }

    subscript(mazeID: MazeRectengular.ID?) -> MazeRectengular? {
        guard let mazeID else { return nil }
        if mazesByID == nil {
            mazesByID = Dictionary(
                uniqueKeysWithValues: mazes.map { ($0.id, $0) })
        }
        return mazesByID![mazeID]
    }

    var mazeOfTheDay: MazeRectengular {
        mazes[0]
    }
}
