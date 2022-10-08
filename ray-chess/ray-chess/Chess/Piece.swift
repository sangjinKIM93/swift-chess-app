//
//  Piece.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/25.
//

import Foundation

protocol Piecable {
    var position: Position { get set }
    var color: Piece.Color { get }
    var name: String { get }
    var maxCount: Int { get }
    var moveType: Piece.MoveType { get }
    var point: Int { get }
    
    func reachableDirections() -> [Piece.Direction]
    func reachablePositions() -> [Position]
    func initializablePositions() -> [Position]
    func getSymbol() -> String
    func getMaximumStep() -> Int
}

extension Piecable {
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
}

enum Piece {
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


