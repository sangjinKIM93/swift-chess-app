//
//  Rock.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Rook: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+265C" : "U+2656",
            point: 5,
            maxCount: 2,
            moveType: .line
        )
    }

    override func reachableDirections() -> [Piece.Direction] {
        return [.top, .bottom, .left, .right]
    }
    
    override func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .A), Position(rank: .one, file: .H)]
        case .white:
            return [Position(rank: .eight, file: .A), Position(rank: .eight, file: .H)]
        }
    }
    
    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♖"
        case .black:
            return "♜"
        }
    }
    
    
}
