//
//  TapRectangle.swift
//  Maze
//
//  Created by Janiece Eleonour on 20.09.2024.
//
import SwiftUI

struct TapRectangle: View {
    @Binding var start: CGPoint?
    @Binding var end: CGPoint?
    @Binding var shortWay: [CGPoint]
    var maze: Maze
    var id: CGPoint
    
    var body: some View {
        Rectangle()
            .fill(id == start || id == end ? Color.path : Color.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    if start == nil {
                        start = id
                    } else if end == nil {
                        end = id
                        shortWay = maze.findPath(from: start ?? .zero, to: end ?? .zero)
                    } else {
                        shortWay = []
                        start = nil
                        end = nil
                    }
                }
            }
#if os(iOS)
            .defersSystemGestures(on: .all)
#endif
    }
}
