//
//  King.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/10.
//

import Foundation

class King: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+265A" : "U+2654",
            point: 3,
            maxCount: 2,
            moveType: .dot
        )
    }
    
    override func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .D)]
        case .white:
            return [Position(rank: .eight, file: .D)]
        }
    }
    
    override func reachablePositions() -> [Position] {
        var positions = [Position]()
        Piece.Direction.allCases.forEach({ direction in
            let file = direction.getRawValue().file
            let rank = direction.getRawValue().rank
            
            if let rank = position.rank.getPoint(added: rank),
               let file = position.file.getPoint(added: file) {
                positions.append(.init(rank: rank, file: file))
            }
        })
        return positions
    }
    
    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♔"
        case .black:
            return "♚"
        }
    }
}
