//
//  Piece.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/25.
//

import Foundation

protocol Movable {
    var maxCount: Int { get set }
    var moveType: Piece.MoveType { get set }
    
    func reachableDirections() -> [Piece.Direction]
    func reachablePositions() -> [Position]
    func getMaximumStep() -> Int
}

class Piece: Movable {
    var position: Position
    let color: Piece.Color
    let name: String
    let point: Int
    var maxCount: Int
    var moveType: MoveType
    
    init(
        position: Position,
        color: Piece.Color,
        name: String,
        point: Int,
        maxCount: Int,
        moveType: MoveType
    ) {
        self.position = position
        self.color = color
        self.name = name
        self.point = point
        self.maxCount = maxCount
        self.moveType = moveType
    }
    
    func initializablePositions() -> [Position] {
        return []
    }
    
    func getSymbol() -> String {
        return ""
    }
    
    func reachableDirections() -> [Piece.Direction] {
        return []
    }
    
    func reachablePositions() -> [Position] {
        return []
    }
    
    func getMaximumStep() -> Int {
        let maximumStep = max(
            (Position.File.H.rawValue) - self.position.file.rawValue,
            (Position.Rank.eight.rawValue) - self.position.rank.rawValue,
            self.position.file.rawValue,
            self.position.rank.rawValue
        )
        
        return maximumStep
    }

    enum Color {
        case white
        case black
        
        func getNext() -> Piece.Color {
            switch self {
            case .white:
                return .black
            case .black:
                return .white
            }
        }
    }
    
    enum MoveType {
        case line
        case dot
    }
    
    enum Direction: CaseIterable {
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
