//
//  MazeGrid.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct MazeGrid: View {
    var dataModel = MazeDataModel.shared

    /// The category of mazes to display.
    let category: MazeCategory?

    /// The mazes of the category.
    private var mazes: [Maze] {
        dataModel.mazes(in: category)
    }

    /// A `Binding` to the identifier of the selected maze.
    @Binding var selection: Maze.ID?

    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(MazeNavigationModel.self) private var navigationModel

    /// The currently-selected maze.
    private var selectedMaze: Maze? {
        dataModel[selection]
    }

    private func gridItem(for maze: Maze) -> some View {
        MazeTile(maze: maze, isSelected: selection == maze.id)
            .id(maze.id)
            .padding(Self.spacing)
            .onTapGesture {
                navigationModel.selectedMazeID = maze.id
            }
    }

    var body: some View {
        if let category = category {
            container { geometryProxy, scrollViewProxy in
                LazyVGrid(columns: columns) {
                    ForEach(mazes) { maze in
                        gridItem(for: maze)
                    }
                }
                .padding(Self.spacing)
                .focusable()
                .focusEffectDisabled()
                .focusedValue(\.selectedMaze, selectedMaze)
                .onKeyPress(.return, action: {
                    if let maze = selectedMaze {
                        navigate(to: maze)
                        return .handled
                    } else {
                        return .ignored
                    }
                })
                .onKeyPress(.escape) {
                    selection = nil
                    return .handled
                }
                .onKeyPress(characters: .alphanumerics, phases: .down) { keyPress in
                    selectMaze(
                        matching: keyPress.characters,
                        scrollViewProxy: scrollViewProxy)
                }
            }
            .navigationTitle(category.name)
            .navigationDestination(for: Maze.ID.self) { mazeID in
                if let maze = dataModel[mazeID] {
                    MazeDetail(maze: maze)
                }
            }
        } else {
            ContentUnavailableView("Choose a category", systemImage: "square.grid.3x3.topleft.filled")
                .navigationTitle("")
        }
    }

    private func container<Content: View>(
        @ViewBuilder content: @escaping (
            _ geometryProxy: GeometryProxy, _ scrollViewProxy: ScrollViewProxy) -> Content
    ) -> some View {
        GeometryReader { geometryProxy in
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    content(geometryProxy, scrollViewProxy)
                }
            }
        }
    }

    // MARK: Keyboard selection

    private func navigate(to maze: Maze) {
        navigationModel.selectedMazeID = maze.id
    }

    private func selectMaze(
        matching characters: String,
        scrollViewProxy: ScrollViewProxy
    ) -> KeyPress.Result {
        if let matchedMaze = mazes.first(where: { maze in
            maze.name.lowercased().starts(with: characters)
        }) {
            selection = matchedMaze.id
            scrollViewProxy.scrollTo(selection)
            return .handled
        }
        return .ignored
    }

    // MARK: Grid layout

    private static let spacing: CGFloat = 10

    private var columns: [GridItem] {
        [ GridItem(.adaptive(minimum: MazeTile.size), spacing: 0) ]
    }
}
