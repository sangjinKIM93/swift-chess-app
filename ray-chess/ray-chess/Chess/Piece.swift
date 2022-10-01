//
//  Piece.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/25.
//

import Foundation

class Piece {
    var position: Piece.Position
    var color: Piece.Color
    var name: String
    
    init(color: Piece.Color, position: Piece.Position, name: String) {
        self.color = color
        self.position = position
        self.name = name
    }
    
    func getColor() -> Piece.Color {
        return self.color
    }
    
    func getPosition() -> Piece.Position {
        return self.position
    }
    
    struct Position {
        var rank: Rank
        var file: File
    }
    
    enum Color {
        case white
        case black
        
        func getSymbolString() -> String {
            switch self {
            case .white:
                return "9"
            case .black:
                return "F"
            }
        }
    }
}

enum File: Int, CaseIterable {
    case A = 0, B, C, D, E, F, G, H
}

enum Rank: Int, CaseIterable {
    case one = 0, two, three, four, five, six, seven, eight
}
