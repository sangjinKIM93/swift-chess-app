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
            self.name = "U+2659"
        case .black:
            self.name = "U+265F"
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
    
    func initializablePositions() -> [Piece.Position] {
        var positions = [Piece.Position]()
        
        switch color {
        case .white:
            File.allCases.forEach { file in
                positions.append(Piece.Position(rank: .seven, file: file))
            }
        case .black:
            File.allCases.forEach { file in
                positions.append(Piece.Position(rank: .two, file: file))
            }
        }
        return positions
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

