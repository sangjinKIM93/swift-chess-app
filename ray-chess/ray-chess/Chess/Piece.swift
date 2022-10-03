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
    var moveType: Piece.MoveType { get set }
    
    func reachableDirections() -> [Piece.Direction]
    func reachablePositions() -> [Piece.Position]
    func initializablePositions() -> [Piece.Position]
    func getSymbol() -> String
    func getMaximumStep() -> Int
}

extension Piecable {
    func reachableDirections() -> [Piece.Direction] {
        return []
    }
    func reachablePositions() -> [Piece.Position] {
        return []
    }
    func getMaximumStep() -> Int {
        let maximumStep = max(
            (File.H.rawValue) - self.position.file.rawValue,
            (Rank.eight.rawValue) - self.position.rank.rawValue,
            self.position.file.rawValue,
            self.position.rank.rawValue
        )
        
        return maximumStep
    }
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
    
    enum MoveType {
        case line
        case dot
    }
    
    enum Direction {
        case top
        case topRight
        case right
        case rightBottom
        case bottom
        case bottomLeft
        case left
        case leftTop
        
        func getRawValue() -> (file: Int, rank: Int) {
            switch self {
            case .top:
                return (1, 0)
            case .topRight:
                return (1, 1)
            case .right:
                return (0, 1)
            case .rightBottom:
                return (-1, 1)
            case .bottom:
                return (-1, 0)
            case .bottomLeft:
                return (-1, -1)
            case .left:
                return (0, -1)
            case .leftTop:
                return (1, -1)
            }
        }
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
