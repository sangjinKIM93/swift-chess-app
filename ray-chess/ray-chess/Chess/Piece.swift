//
//  Piece.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/25.
//

import Foundation

protocol Piecable {
    var position: Piece.Position { get set }
    var color: Piece.Color { get set }
    var name: String { get set }
    var maxCount: Int { get set }
    func reachablePosition() -> [Piece.Position]
    func initializablePositions() -> [Piece.Position]
    func getSymbol() -> String
}

enum Piece {
    struct Position: Equatable {
        var rank: Rank
        var file: File
    }
    
    enum Color {
        case white
        case black
    }
}

enum File: Int, CaseIterable {
    case A = 0, B, C, D, E, F, G, H
    
    func getPoint(added: Int) -> File? {
        let file = self.rawValue + added
        return File(rawValue: file)
    }
}

enum Rank: Int, CaseIterable {
    case one = 0, two, three, four, five, six, seven, eight
    
    func getPoint(added: Int) -> Rank? {
        let rank = self.rawValue + added
        return Rank(rawValue: rank)
    }
}
