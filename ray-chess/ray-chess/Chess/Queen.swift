//
//  Queen.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Queen: Piecable {
    var position: Piece.Position
    let color: Piece.Color
    let name: String
    let maxCount: Int = 1
    let moveType: Piece.MoveType = .line
    let point: Int = 9
    
    init(color: Piece.Color, position: Piece.Position) {
        self.color = color
        self.position = position
        
        switch color {
        case .white:
            self.name = "U+2655"
        case .black:
            self.name = "U+265B"
        }
    }
    
    func initializablePositions() -> [Piece.Position] {
        switch color {
        case .black:
            return [Piece.Position(rank: .one, file: .E)]
        case .white:
            return [Piece.Position(rank: .eight, file: .E)]
        }
    }
    
    func reachableDirections() -> [Piece.Direction] {
        return Piece.Direction.allCases
    }
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♖"
        case .black:
            return "♛"
        }
    }
    
    
}
