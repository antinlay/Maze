//
//  MazeTests.swift
//  MazeTests
//
//  Created by Janiece Eleonour on 03.09.2024.
//

import XCTest
@testable import Maze

final class MazeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFindPathEmptyMaze() {
        let maze = Maze(col: 0, row: 0)
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 0, y: 0)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [])
    }

    func testFindPathSingleCellMaze() {
        let maze = Maze(col: 1, row: 1)
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 0, y: 0)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [CGPoint(x: 0.5, y: 0.5)])
    }

    func testFindPathNoPath() {
        var maze = Maze(col: 2, row: 2)
        maze.lowerWalls[0][0] = true
        maze.lowerWalls[0][1] = true
        maze.rightWalls[0][0] = true
        maze.rightWalls[1][0] = true
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 1, y: 1)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [])
    }

    func testFindPathHorizontalPath() {
        var maze = Maze(col: 2, row: 1)
        maze.lowerWalls[0][0] = false
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 1, y: 0)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 1.5, y: 0.5)])
    }

    func testFindPathVerticalPath() {
        var maze = Maze(col: 1, row: 2)
        maze.rightWalls[0][0] = false
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 0, y: 1)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.5)])
    }

    func testFindPathDiagonalPath() {
        var maze = Maze(col: 2, row: 2)
        maze.lowerWalls[0][0] = false
        maze.rightWalls[0][0] = false
        let start = CGPoint(x: 0, y: 0)
        let end = CGPoint(x: 1, y: 1)
        let path = maze.findPath(from: start, to: end)
        XCTAssertEqual(path, [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 1.5, y: 0.5), CGPoint(x: 1.5, y: 1.5)])
    }


}
