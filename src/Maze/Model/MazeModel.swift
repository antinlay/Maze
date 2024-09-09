//
//  MazeModel.swift
//  Maze
//
//  Created by Chingisbek Anvardinov on 05.09.2024.
//

import Foundation

struct Maze {
    var horizontalWalls: [[Bool]]
    var verticalWalls: [[Bool]]
    private var _col: Int
    private var _row: Int
    
    var col: Int {
        get { return _col }
        set {
            guard newValue > 0, newValue != _col else { return }
            self._col = newValue
            
            self.horizontalWalls = resizeMatrix(newCols: _col, newRows: _row, matrix: horizontalWalls)
            self.verticalWalls = resizeMatrix(newCols: _col, newRows: _row, matrix: verticalWalls)
        }
    }
    
    var row: Int {
        get { return _row }
        set {
            guard newValue > 0, newValue != _row else { return }
            self._row = newValue
            
            self.horizontalWalls = resizeMatrix(newCols: _col, newRows: _row, matrix: horizontalWalls)
            self.verticalWalls = resizeMatrix(newCols: _col, newRows: _row, matrix: verticalWalls)
        }
    }
    
    init(col: Int, row: Int) {
//        guard col > 0 && row > 0 else {
//            throw fatalError("Matrix is not valid cols = \(col), rows = \(row)")
//        }
        self._col = col
        self._row = row
        self.horizontalWalls = Array(repeating: Array(repeating: true, count: _col), count: _row)
        self.verticalWalls = Array(repeating: Array(repeating: true, count: _col), count: _row)
    }
    
    init() {
        self._col = 0
        self._row = 0
        self.horizontalWalls = [[]]
        self.verticalWalls = [[]]
    }
    
    private func resizeMatrix(newCols: Int, newRows: Int, matrix: Array<Array<Bool>>) -> [[Bool]] {
        var newMatrix: [[Bool]] = Array(repeating: Array(repeating: false, count: newCols), count: newRows)
        for (i, row) in matrix.enumerated() {
            for (k, element) in row.enumerated() {
                if i < newRows && k < newCols {
                    newMatrix[i][k] = element
                }
            }
        }
        return newMatrix
    }
    
    func printBothMatrix() {
        print("horizontal")
        printMatrix(horizontalWalls)
        print("\nvertical")
        printMatrix(verticalWalls)
    }
    
    func printMatrix(_ matrix: Array<Array<Bool>>) {
        for row in matrix {
            for element in row {
                print(element ? 1 : 0, terminator: " ")
            }
            print("")
        }
    }
}    // struct Maze
