//
//  Direction.swift
//  Maze
//
//  Created by Melania Dababi on 9/6/24.
//

import Foundation

extension CGPoint {
    var i: Int {
        Int(y)
    }
    var j: Int {
        Int(x)
    }
}

extension Maze {
    
    enum CellValue: Int {
        case unvisited = -1
        case visited = 0
        
//        var value : Int {
//            switch self {
//            case .unvisited: -1
//            case .visited: 0
//            }
//        }
    }

    enum Direction {
        case up, down, left, right
        
    }
    
    private func updateCell(value: Int, cell: Int) -> Int {
        if cell == -1 {
            value
        } else {
            min(cell, value)
        }
    }
    
    private func explorePossibleSteps(step: Int, field: inout [[Int]]) -> Int {
        var result = 0
        
        for i in 0..<row {
            for j in 0..<col where field[i][j] == step {
                result += 1
                if i < row - 1 && horizontalWalls[i][j] == false {
                    field[i + 1][j] = updateCell(value: step + 1, cell: field[i + 1][j])
                }
                if i > 0 && horizontalWalls[i - 1][j] == false {
                    field[i - 1][j] = updateCell(value: step + 1, cell: field[i - 1][j])
                }
                if j < col - 1 && verticalWalls[i][j] == false {
                    field[i][j + 1] = updateCell(value: step + 1, cell: field[i][j + 1])
                }
                if j > 0 && verticalWalls[i][j - 1] == false {
                    field[i][j - 1] = updateCell(value: step + 1, cell: field[i][j - 1])
                }
            }
        }
        
        return result
    }
    
    public func findPath(from start: CGPoint, to end: CGPoint) -> [CGPoint] {
        var route = [CGPoint]()
        var j = end.j
        var i = end.i
        var count = 1
        var step = 0
        var field = Array(repeating: Array(repeating: -1, count: col), count: row)
        
        field[start.i][start.j] = 0
        
        while count > 0 && field[i][j] == -1 {
            count = explorePossibleSteps(step: step, field: &field)
            step += 1
        }
        
        if field[i][j] != -1 {
            step = field[i][j]
            route.append(CGPoint(x: Double(j) + 0.5, y: Double(i) + 0.5))
            
            while i != start.i || j != start.j {
                if i < row - 1 && horizontalWalls[i][j] == false && field[i + 1][j] == step - 1 {
                    i += 1
                } else if i > 0 && horizontalWalls[i - 1][j] == false && field[i - 1][j] == step - 1 {
                    i -= 1
                } else if j < col - 1 && verticalWalls[i][j] == false && field[i][j + 1] == step - 1 {
                    j += 1
                } else if j > 0 && verticalWalls[i][j - 1] == false && field[i][j - 1] == step - 1 {
                    j -= 1
                }
                route.append(CGPoint(x: Double(j) + 0.5, y: Double(i) + 0.5))
                step -= 1
            }
        }
        return route
    }
}
