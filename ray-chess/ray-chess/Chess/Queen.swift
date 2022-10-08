//
//  Queen.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Queen: Piecable {
    var position: Position
    let color: Piece.Color
    let name: String
    let maxCount: Int = 1
    let moveType: Piece.MoveType = .line
    let point: Int = 9
    
    init(color: Piece.Color, position: Position) {
        self.color = color
        self.position = position
        
        switch color {
        case .white:
            self.name = "U+2655"
        case .black:
            self.name = "U+265B"
        }
    }
    
    func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .E)]
        case .white:
            return [Position(rank: .eight, file: .E)]
        }
    }
    
    func reachableDirections() -> [Piece.Direction] {
        return Piece.Direction.allCases
    }
    
    func getSymbol() -> String {
        switch color {
        case .white:
            return "♕"
        case .black:
            return "♛"
        }
    }
    
    
}
