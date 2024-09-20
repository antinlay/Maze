//
//  Direction.swift
//  Maze
//
//  Created by Melania Dababi on 9/6/24.
//

import Foundation

extension CGPoint {
    var i: Int {
        get { Int(y) }
        set { y = Double(newValue)}
    }
    var j: Int {
        get { Int(x) }
        set { x = Double(newValue)}
    }
}

extension Int {
    var down: Int { self + 1 }
    var up: Int { self - 1 }
    var left: Int { self - 1 }
    var right: Int { self + 1 }
}

extension Maze {
    private func updateCell(value: Int, cell: Int) -> Int {
        cell == -1 ? value : min(cell, value)
    }
    
    private func explorePossibleSteps(step: Int, field: inout [[Int]]) -> Int {
        var result = 0
        
        for i in 0..<row {
            for j in 0..<col where field[i][j] == step {
                result += 1
                if i < row.up && lowerWalls[i][j] == false {
                    field[i.down][j] = updateCell(value: step.right, cell: field[i.down][j])
                }
                if i > 0 && lowerWalls[i.up][j] == false {
                    field[i.up][j] = updateCell(value: step.right, cell: field[i.up][j])
                }
                if j < col.left && rightWalls[i][j] == false {
                    field[i][j.right] = updateCell(value: step.right, cell: field[i][j.right])
                }
                if j > 0 && rightWalls[i][j.left] == false {
                    field[i][j.left] = updateCell(value: step.right, cell: field[i][j.left])
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
                if i < row.up && lowerWalls[i][j] == false && field[i.down][j] == step.left {
                    i += 1
                } else if i > 0 && lowerWalls[i.up][j] == false && field[i.up][j] == step.left {
                    i -= 1
                } else if j < col.left && rightWalls[i][j] == false && field[i][j.right] == step.left {
                    j += 1
                } else if j > 0 && rightWalls[i][j.left] == false && field[i][j.left] == step.left {
                    j -= 1
                }
                route.append(CGPoint(x: Double(j) + 0.5, y: Double(i) + 0.5))
                step -= 1
            }
        }
        return route
    }
}
