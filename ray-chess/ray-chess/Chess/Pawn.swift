//
//  Pawn.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import Foundation

class Pawn: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+265F" : "U+2659",
            point: 1,
            maxCount: 8,
            moveType: .dot
        )
    }
    
    override func reachablePositions() -> [Position] {
        switch color {
        case .white:
            guard let newRank = self.position.rank.getPoint(added: -1) else {
                return []
            }
            return [Position(rank: newRank, file: self.position.file)]
        case .black:
            guard let newRank = self.position.rank.getPoint(added: 1) else {
                return []
            }
            return [Position(rank: newRank, file: self.position.file)]
        }
    }
    
    override func initializablePositions() -> [Position] {
        var positions = [Position]()
        
        switch color {
        case .white:
            Position.File.allCases.forEach { file in
                positions.append(Position(rank: .seven, file: file))
            }
        case .black:
            Position.File.allCases.forEach { file in
                positions.append(Position(rank: .two, file: file))
            }
        }
        return positions
    }
    
    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♙"
        case .black:
            return "♟"
        }
    }
}

