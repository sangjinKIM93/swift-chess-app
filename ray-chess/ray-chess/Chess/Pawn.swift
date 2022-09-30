//
//  Pawn.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import Foundation

class Pawn: Piece {
    
    init(color: Piece.Color, position: Piece.Position) {
        switch color {
        case .white:
            super.init(color: color, position: position, name: PawnConst.whiteName)
        case .black:
            super.init(color: color, position: position, name: PawnConst.blackName)
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

