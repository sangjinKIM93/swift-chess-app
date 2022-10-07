//
//  Rock.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/03.
//

import Foundation

class Rook: Piecable {
    var position: Position
    let color: Piece.Color
    let name: String
    let maxCount: Int = 2
    let moveType: Piece.MoveType = .line
    let point: Int = 5
    
    init(color: Piece.Color, position: Position) {
        self.color = color
        self.position = position

        switch color {
        case .white:
            self.name = "U+2656"
        case .black:
            self.name = "U+265C"
        }
    }
    
    func reachableDirections() -> [Piece.Direction] {
        return [.top, .bottom, .left, .right]
    }
    
//    func reachablePositions() -> [Piece.Position] {
//        var positions = [Piece.Position]()
//
//        File.allCases.forEach { file in
//            if file != position.file {
//                positions.append(Piece.Position(rank: position.rank, file: file))
//            }
//        }
//        Rank.allCases.forEach { rank in
//            if rank != position.rank {
//                positions.append(Piece.Position(rank: rank, file: position.file))
//            }
//        }
//
//        return positions
//    }
    
    func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .A), Position(rank: .one, file: .H)]
        case .white:
            return [Position(rank: .eight, file: .A), Position(rank: .eight, file: .H)]
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
