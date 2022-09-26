//
//  Piece.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/25.
//

import Foundation

class Piece {
    var position: PiecePosition
    var color: PieceColor
    var name: String
    
    init(color: PieceColor, position: PiecePosition, name: String) {
        self.color = color
        self.position = position
        self.name = name
    }
    
    func getColor() -> PieceColor {
        return self.color
    }
    
    func getPosition() -> PiecePosition {
        return self.position
    }
}


struct PiecePosition {
    var rank: Int
    var file: Int
}

enum PieceColor {
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
