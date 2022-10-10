//
//  Knight.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Knight: Piece {
    init(color: Piece.Color, position: Position) {
        super.init(
            position: position,
            color: color,
            name: color == .black ? "U+265E" : "U+2658",
            point: 3,
            maxCount: 2,
            moveType: .dot
        )
    }
    
    override func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .B), Position(rank: .one, file: .G)]
        case .white:
            return [Position(rank: .eight, file: .B), Position(rank: .eight, file: .G)]
        }
    }
    
    override func reachablePositions() -> [Position] {
        var positions = [Position]()
        [(2,-1), (2,1), (-2,-1), (-2,1), (1,-2), (-1,-2), (1,2), (-1,2)]
            .forEach { (file: Int, rank: Int) in
            if let rank = position.rank.getPoint(added: rank),
               let file = position.file.getPoint(added: file) {
                positions.append(.init(rank: rank, file: file))
            }
        }
        return positions
    }
    
    override func getSymbol() -> String {
        switch color {
        case .white:
            return "♘"
        case .black:
            return "♞"
        }
    }
    
    
}
