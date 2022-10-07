//
//  Knight.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Knight: Piecable {
    var position: Piece.Position
    let color: Piece.Color
    let name: String
    let maxCount: Int = 2
    let moveType: Piece.MoveType = .dot
    
    init(color: Piece.Color, position: Piece.Position) {
        self.color = color
        self.position = position
        
        switch color {
        case .white:
            self.name = "U+2658"
        case .black:
            self.name = "U+265E"
        }
    }
    
    func initializablePositions() -> [Piece.Position] {
        switch color {
        case .black:
            return [Piece.Position(rank: .one, file: .B), Piece.Position(rank: .one, file: .G)]
        case .white:
            return [Piece.Position(rank: .eight, file: .B), Piece.Position(rank: .eight, file: .G)]
        }
    }
    
    func reachablePositions() -> [Piece.Position] {
        var positions = [Piece.Position]()
        [(2,-1), (2,1), (-2,-1), (-2,1), (1,-2), (-1,-2), (1,2), (-1,2)]
            .forEach { (file: Int, rank: Int) in
            if let rank = position.rank.getPoint(added: rank),
               let file = position.file.getPoint(added: file) {
                positions.append(.init(rank: rank, file: file))
            }
        }
        return positions
    }
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♘"
        case .black:
            return "♞"
        }
    }
    
    
}
