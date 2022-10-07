//
//  Pawn.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import Foundation

class Pawn: Piecable {
    var position: Position
    let color: Piece.Color
    let name: String
    let maxCount: Int
    let moveType: Piece.MoveType = .dot
    let point: Int = 1
    
    init(color: Piece.Color, position: Position) {
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
    
    func reachablePositions() -> [Position] {
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
    
    func initializablePositions() -> [Position] {
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
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♙"
        case .black:
            return "♟"
        }
    }
}

