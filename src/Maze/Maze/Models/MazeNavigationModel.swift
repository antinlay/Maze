//
//  MazeNavigationModel.swift
//  Maze
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftUI
import Observation

@Observable final class MazeNavigationModel {
    var selectedCategory: MazeCategory?
    var mazePath: [Maze.ID] = []
}
