//
//  Rock.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Rook: Piecable {
    var position: Piece.Position
    var color: Piece.Color
    var name: String
    var maxCount: Int = 2
    
    init(color: Piece.Color, position: Piece.Position) {
        self.color = color
        self.position = position
        self.maxCount = 8

        switch color {
        case .white:
            self.name = "U+2656"
        case .black:
            self.name = "U+265C"
        }
    }
    
    func reachablePositions() -> [Piece.Position] {
        var positions = [Piece.Position]()
        
        File.allCases.forEach { file in
            if file != position.file {
                positions.append(Piece.Position(rank: position.rank, file: file))
            }
        }
        Rank.allCases.forEach { rank in
            if rank != position.rank {
                positions.append(Piece.Position(rank: rank, file: position.file))
            }
        }
        
        return positions
    }
    
    func initializablePositions() -> [Piece.Position] {
        switch color {
        case .white:
            return [Piece.Position(rank: .one, file: .A), Piece.Position(rank: .one, file: .H)]
        case .black:
            return [Piece.Position(rank: .eight, file: .A), Piece.Position(rank: .eight, file: .H)]
        }
    }
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♖"
        case .black:
            return "♜"
        }
    }
    
    
}
