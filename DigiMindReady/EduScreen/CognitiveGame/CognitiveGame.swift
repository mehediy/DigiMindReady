//
//  CognitiveGame.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 4/18/24.
//

import Foundation

enum CognitiveGame: Int, CaseIterable, Identifiable {
    
    case numberPuzzle
    case crosswordPuzzles
    case sudoku
    case scrabble
    case memoryCard
    case jigsawPuzzles
    
    
    var title: String {
        switch self {
        case .crosswordPuzzles:
            "Crossword Puzzles"
        case .sudoku:
            "Sudoku"
        case .scrabble:
            "Scrabble"
        case .memoryCard:
            "Memory Card Game"
        case .jigsawPuzzles:
            "Jigsaw Puzzles"
        case .numberPuzzle:
            "Number Puzzle"
        }
    }
    
    var iconName: String {
        switch self {
        case .crosswordPuzzles:
            "CrosswordPuzzles"
        case .sudoku:
            "Sudoku"
        case .scrabble:
            "Scrabble"
        case .memoryCard:
            "MemoryCard"
        case .jigsawPuzzles:
            "JigsawPuzzles"
        case .numberPuzzle:
            "2048"
        }
    }
    
    nonisolated var id: Int {
        rawValue
    }
    
}
