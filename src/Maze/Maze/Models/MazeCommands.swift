//
//  MazeCommands.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct SelectedMzeKey: FocusedValueKey {
    typealias Value = Maze
}

extension FocusedValues {
    var selectedMaze: SelectedMzeKey.Value? {
        get { self[SelectedMzeKey.self] }
        set { self[SelectedMzeKey.self] = newValue }
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
