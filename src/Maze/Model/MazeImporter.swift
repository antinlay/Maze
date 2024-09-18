//
//  MazeImporter.swift
//  Maze
//
//  Created by Janiece Eleonour on 14.09.2024.
//

import SwiftUI

enum ImportErrorSaver: LocalizedError {
    case parseError(String)
    case fileNotFound(String)
    case invalidData(String)
    
    var errorDescription: String? {
        switch self {
        case .parseError(let message):
            "Parse error: \(message)"
        case .fileNotFound(let fileName):
            "File not found: \(fileName)"
        case .invalidData(let message):
            "Invalid data: \(message)"
        }
    }
}


//struct MazeImporter<Content: View>: View {
//    @State private var isPresented: Bool = false
//    @State private var text: String = ""
//    @State private var maze: MazeRectangular = Maze().toMazeRectangular
//    @State private var showAlert: Bool = false
//    @State private var error: ImportErrorSaver?
//    
//    var body: some View {
//            .alert(isPresented: $showAlert, error: error) { _ in
//                Button("OK") {
//                    showAlert = false
//                }
//            } message: { error in
//                Text(error.recoverySuggestion ?? "Try again later.")
//            }
//        .fileImporter(isPresented: $isPresented,
//                      allowedContentTypes: [.text]) {
//            let result = $0.flatMap { url in
//                read(from: url)
//            }
//            switch result {
//            case .success(let strings):
//                text += strings
//                
//                
//            case .failure(let failure):
//                error = .invalidData(failure.localizedDescription)
//                showAlert = true
//            }
//        }
//    }
//    
//    private func read(from url: URL) -> Result<String,Error> {
//        let accessing = url.startAccessingSecurityScopedResource()
//        defer {
//            if accessing {
//                url.stopAccessingSecurityScopedResource()
//            }
//        }
//        
//        return Result { try String(contentsOf: url) }
//    }
//}


