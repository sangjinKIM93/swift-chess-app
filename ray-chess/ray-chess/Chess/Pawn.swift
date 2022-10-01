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
            self.name = PawnConst.whiteName
        case .black:
            self.name = PawnConst.blackName
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
}

struct PawnConst {
    static let maxCount: Int = 8
    static let whiteStartRank: Int = 7
    static let blackStartRank: Int = 2
    static let blackName = "U+256F"
    static let whiteName = "U+2569"
}

