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
    
    var selectedMazeID: Maze.ID? {
        get { mazePath.first }
        set { mazePath = [newValue].compactMap { $0 } }
    }

}
