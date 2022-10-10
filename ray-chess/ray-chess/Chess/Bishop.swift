//
//  Bishop.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/02.
//

import Foundation

class Bishop: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+2657" : "U+265D",
            point: 3,
            maxCount: 2,
            moveType: .line
        )
    }
    
    override func reachableDirections() -> [Piece.Direction] {
        return [.topRight, .rightBottom, .bottomLeft, .leftTop]
    }

    override func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .C), Position(rank: .one, file: .F)]
        case .white:
            return [Position(rank: .eight, file: .C), Position(rank: .eight, file: .F)]
        }
    }

    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♗"
        case .black:
            return "♝"
        }
    }
}
