//
//  MazeTile.swift
//  Maze
//
//  Created by Janiece Eleonour on 09.09.2024.
//

import SwiftUI

struct MazeTile: View {
    var maze: MazeRectengular
    var isSelected: Bool
    
    private var strokeStyle: AnyShapeStyle {
        isSelected
            ? AnyShapeStyle(.selection)
            : AnyShapeStyle(.clear)
    }
    
    var body: some View {
        VStack {
            imageView
            captionView
        }
    }
}

extension MazeTile {
    static let size: CGFloat = 240
    static let selectionStrokeWidth: CGFloat = 4
}

extension MazeTile {
    private var imageView: some View {
        MazeImage(maze: maze)
            .frame(minWidth: 120, maxWidth: Self.size)
            .aspectRatio(1, contentMode: .fill)
            .clipShape(.containerRelative)
            .padding(Self.selectionStrokeWidth)
            .overlay(
                ContainerRelativeShape()
                    .inset(by: -Self.selectionStrokeWidth / 1.5)
                    .strokeBorder(
                        strokeStyle,
                        lineWidth: Self.selectionStrokeWidth)
            )
            .shadow(color: .black.opacity(0.05), radius: 0.5, x: 0, y: -1)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            .containerShape(.rect(cornerRadius: 20))
    }
    
    private var captionView: some View {
        Text(maze.name)
            .lineLimit(1)
            .truncationMode(.tail)
            .font(.headline)
    }
}

#Preview {
    MazeTile(maze: .mazes.first!, isSelected: true)
}
