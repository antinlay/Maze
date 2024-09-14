//
//  MazeExporter.swift
//  Maze
//
//  Created by Janiece Eleonour on 14.09.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct TextFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    // by default our document is empty
    var text = ""

    // a simple initializer that creates new, empty documents
    init(initialText: String = "") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

extension Maze {
    public func parseMazeToText() -> String {
        let rows = horizontalWalls.count
        let columns = horizontalWalls[0].count

        var result = "\(rows) \(columns)\n"

        for i in 0..<rows {
            for j in 0..<columns {
                result += horizontalWalls[i][j] ? "1 " : "0 "
            }
            result += "\n"
        }
        
        result += "\n"

        for i in 0..<rows {
            for j in 0..<columns {
                result += verticalWalls[i][j] ? "1 " : "0 "
            }
            result += "\n"
        }

        return result
    }

}
