//
//  MazeRectangularGrid.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftData
import SwiftUI

struct MazeRectangularGrid: View {
    @Environment(\.modelContext) var modelContext
    /// The mazes of the category.
    @Query(sort: [SortDescriptor(\MazeRectangular.name, order: .forward)]) var mazes: [MazeRectangular]
    
    /// The category of mazes to display.
    let category: MazeCategory?

    /// A `Binding` to the identifier of the selected maze.
    @Binding var selection: MazeRectangular.ID?

    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(MazeNavigationModel.self) private var navigationModel

    /// The currently-selected maze.
    private var selectedMaze: MazeRectangular? {
        mazes.first { $0.id == selection }
    }

    private func gridItem(for maze: MazeRectangular) -> some View {
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
            .toolbar {
                Button("Add Samples") {
                    addSamples()
                }
            }
            .navigationTitle(category.name)
            .navigationDestination(for: MazeRectangular.ID.self) { mazeID in
                if let maze = mazes[mazeID] {
                    MazeDetail(mazeRectangular: maze)
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

    private func navigate(to maze: MazeRectangular) {
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
    
    // Add samples
    func addSamples() {
        do {
            try modelContext.delete(model: MazeRectangular.self)
        } catch {
            print("Failed to delete students.")
        }
        MazeRectangular.mazes.forEach { maze in
            modelContext.insert(maze)
        }
    }
}
