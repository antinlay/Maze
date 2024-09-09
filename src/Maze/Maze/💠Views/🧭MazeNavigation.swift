//
//  🧭MazeNavigation.swift
//  Maze
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftUI

struct MazeNavigation: View {
    @Bindable var mazeNavigationModel: MazeNavigationModel
    
    @State var selectedMaze: Maze.ID?
    var categories = MazeCategory.allCases
    
    
    
    var body: some View {
        NavigationSplitView {
            List(categories, selection: $mazeNavigationModel.selectedCategory) { category in
                NavigationLink(category.name, value: category)
            }
            .navigationTitle("Categories")
        } detail: {
            NavigationStack(path: $mazeNavigationModel.mazePath) {
                MazeGrid(category: mazeNavigationModel.selectedCategory, selection: $selectedMaze)
            }
        }
    }
}

