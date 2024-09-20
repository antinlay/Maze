//
//  MazeCommands.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct SelectedMazeKey: FocusedValueKey {
    typealias Value = MazeData
}

extension FocusedValues {
    var selectedMaze: SelectedMazeKey.Value? {
        get { self[SelectedMazeKey.self] }
        set { self[SelectedMazeKey.self] = newValue }
    }
}


struct MazeCommands: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MazeCommands()
}
