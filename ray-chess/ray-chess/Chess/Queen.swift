//
//  Queen.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Queen: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+265B" : "U+2655",
            point: 9,
            maxCount: 1,
            moveType: .line
        )
    }
    
    override func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .E)]
        case .white:
            return [Position(rank: .eight, file: .E)]
        }
    }
    
    override func reachableDirections() -> [Piece.Direction] {
        return Piece.Direction.allCases
    }
    
    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♕"
        case .black:
            return "♛"
        }
    }
    
    
}
