//
//  Direction.swift
//  Maze
//
//  Created by Melania Dababi on 9/6/24.
//

import Foundation

extension Maze {
    struct Coordinate: Equatable {
        let x: Int
        let y: Int
    }
    
    private func updateCell(value: Int, cell: Int) -> Int {
        if cell == -1 {
            value
        } else {
            min(cell, value)
        }
    }
    
    private func explorePossibleSteps(step: Int, map: inout [[Int]]) -> Int {
        var result = 0
        
        for i in 0..<row {
            for j in 0..<col where map[i][j] == step {
                result += 1
                if i < row - 1 && horizontalWalls[i][j] == false {
                    map[i + 1][j] = updateCell(value: step + 1, cell: map[i + 1][j])
                }
                if i > 0 && horizontalWalls[i - 1][j] == false {
                    map[i - 1][j] = updateCell(value: step + 1, cell: map[i - 1][j])
                }
                if j < col - 1 && verticalWalls[i][j] == false {
                    map[i][j + 1] = updateCell(value: step + 1, cell: map[i][j + 1])
                }
                if j > 0 && verticalWalls[i][j - 1] == false {
                    map[i][j - 1] = updateCell(value: step + 1, cell: map[i][j - 1])
                }
            }
        }
        
        return result
    }
    
    public func findPath(from start: Coordinate, to end: Coordinate) -> [Coordinate] {
        var route = [Coordinate]()
        var x = end.x
        var y = end.y
        var count = 1
        var step = 0
        var map = (0..<row).map { _ in
            (0..<col).map { _ in
                -1
            }
        }
        
        map[start.y][start.x] = 0
        
        while count > 0 && map[y][x] == -1 {
            count = explorePossibleSteps(step: step, map: &map)
            step += 1
        }
        
        if map[y][x] != -1 {
            step = map[y][x]
            route.append(Coordinate(x: x, y: y))
            while y != start.y || x != start.x {
                if y < row - 1 && horizontalWalls[y][x] == false && map[y + 1][x] == step - 1 {
                    y += 1
                } else if y > 0 && horizontalWalls[y - 1][x] == false && map[y - 1][x] == step - 1 {
                    y -= 1
                } else if x < col - 1 && verticalWalls[y][x] == false && map[y][x + 1] == step - 1 {
                    x += 1
                } else if x > 0 && verticalWalls[y][x - 1] == false && map[y][x - 1] == step - 1 {
                    x -= 1
                }
                route.append(Coordinate(x: x, y: y))
                step -= 1
            }
        }
        return route
    }
    
}
