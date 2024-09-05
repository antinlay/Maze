//
//  🧭MazeNavigation.swift
//  Maze
//
//  Created by Janiece Eleonour on 05.09.2024.
//

import SwiftUI

struct MazeNavigation: View {
    @Bindable var mazeNavigationModel: MazeNavigationModel
    private var categories = MazeCategory.allCases
    
    var body: some View {
        NavigationSplitView {
            List(categories, selection: $mazeNavigationModel.selectedCategory) { category in
                NavigationLink(category.name, value: category)
            }
        } detail: {
            NavigationStack(path: $mazeNavigationModel.mazePath) {
                
            }
        }
    }
}

