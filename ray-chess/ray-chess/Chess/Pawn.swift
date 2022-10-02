//
//  Pawn.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import Foundation

class Pawn: Piecable {
    var position: Piece.Position
    var color: Piece.Color
    var name: String
    var maxCount: Int
    
    init(color: Piece.Color, position: Piece.Position) {
        self.color = color
        self.position = position
        self.maxCount = 8
        
        switch color {
        case .white:
            self.name = "U+2569"
        case .black:
            self.name = "U+256F"
        }
    }
    
    func reachablePosition() -> [Piece.Position] {
        switch color {
        case .white:
            guard let newRank = self.position.rank.getPoint(added: -1) else {
                return []
            }
            return [Piece.Position(rank: newRank, file: self.position.file)]
        case .black:
            guard let newRank = self.position.rank.getPoint(added: 1) else {
                return []
            }
            return [Piece.Position(rank: newRank, file: self.position.file)]
        }
    }
    
    func isInitializableRank() -> Bool {
        let rank = self.position.rank
        
        switch color {
        case .white:
            return rank == .seven
        case .black:
            return rank == .two
        }
    }
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♙"
        case .black:
            return "♟"
        }
    }
}

