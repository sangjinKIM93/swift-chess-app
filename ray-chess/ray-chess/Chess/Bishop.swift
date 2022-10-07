//
//  Bishop.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/02.
//

import Foundation

class Bishop: Piecable {
    var position: Position
    let color: Piece.Color
    let name: String
    let maxCount: Int = 2
    let moveType: Piece.MoveType = .line
    let point: Int = 3

    init(color: Piece.Color, position: Position) {
        self.color = color
        self.position = position

        switch color {
        case .white:
            self.name = "U+265D"
        case .black:
            self.name = "U+2657"
        }
    }
    
    func reachableDirections() -> [Piece.Direction] {
        return [.topRight, .rightBottom, .bottomLeft, .leftTop]
    }

//    func reachablePositions() -> [Piece.Position] {
//        let maximumReach = max(
//            (File.H.rawValue) - position.file.rawValue,
//            (Rank.eight.rawValue) - position.rank.rawValue,
//            position.file.rawValue,
//            position.rank.rawValue
//        )
//        
//        var positions = [Piece.Position]()
//        for step in 1...maximumReach {
//            positions.append(contentsOf: getReachableDiagonalPostions(step: step))
//        }
//        return positions
//    }
//    
//    func getReachableDiagonalPostions(step: Int) -> [Piece.Position] {
//        var positions = [Piece.Position]()
//        
//        for i in [-1 * step, 1 * step] {
//            for j in [-1 * step, +1 * step] {
//                if let rank = position.rank.getPoint(added: i),
//                   let file = position.file.getPoint(added: j) {
//                    positions.append(Piece.Position(rank: rank, file: file))
//                }
//            }
//        }
//        
//        return positions
//    }

    func initializablePositions() -> [Position] {
        switch color {
        case .black:
            return [Position(rank: .one, file: .C), Position(rank: .one, file: .F)]
        case .white:
            return [Position(rank: .eight, file: .C), Position(rank: .eight, file: .F)]
        }
    }

    func getSymbol() -> String {
        switch color {

        case .white:
            return "♗"
        case .black:
            return "♝"
        }
    }
}
