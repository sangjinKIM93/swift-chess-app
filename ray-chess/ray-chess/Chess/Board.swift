//
//  Board.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import Foundation

// - matrix를 통한 말 위치 관리
// - 말 셋팅 관리
// - 말 움직임 관리
class Board {
    private(set) var matrix: [[Piecable?]]
    
    init() {
        let rank = Array<Piecable?>(repeating: nil, count: 8)
        self.matrix = Array(repeating: rank, count: 8)
    }
    
    func getScore() -> (black: Int, white: Int) {
        var blackScore = 0
        var whiteScore = 0

        matrix.forEach { rank in
            rank.forEach { piece in
                if let piece = piece {
                    switch piece.color {
                    case .white:
                        whiteScore += piece.point
                    case .black:
                        blackScore += piece.point
                    }
                }
            }
        }
        
        return (blackScore, whiteScore)
    }
    
    func display() -> [[String]] {
        matrix.map { rank -> [String] in
            let formattedRank = rank.map { piece -> String in
                guard let piece = piece else {
                    return "."
                }
                return piece.getSymbol()
            }
            return formattedRank
        }
    }
    
    enum SetError: Error {
        case isEmptySpace
        case wrongInitRank
        case isFulledPosition
        case isOverMaxCount
    }
    
    enum MoveError: Error {
        case isEmptySpace
        case isNotMyPiece
        case existSameColorPiece
        case isNotReachable
    }
}

// MARK: - Pawn initialize
extension Board {
    func canSetPiece(piece: Piecable) -> Result<Bool, Board.SetError> {
        guard isCorrectRankPosition(piece: piece) else {
            return .failure(.wrongInitRank)
        }
        guard IsEmptyPosition(position: piece.position) else {
            return .failure(.isFulledPosition)
        }
        guard !IsOverPieceMaxCount(piece: piece) else {
            return .failure(.isOverMaxCount)
        }
        
        return .success(true)
    }
    
    func isCorrectRankPosition(piece: Piecable) -> Bool {
        return piece.initializablePositions().contains(piece.position)
    }
    
    func IsEmptyPosition(position: Position) -> Bool {
        let piece = getPieceOnBoard(position: position)
        
        return piece == nil
    }
    
    func IsOverPieceMaxCount(piece: Piecable) -> Bool {
        let numberOfPiece = theNumberOf(targetPiece: piece)
        return numberOfPiece >= piece.maxCount
    }
    
    func theNumberOf(targetPiece: Piecable) -> Int {
        var num: Int = 0
        matrix.forEach { ranks in
            ranks.forEach { piece in
                if piece?.color == targetPiece.color
                    && piece?.name == targetPiece.name {
                    num += 1
                }
            }
        }
        return num
    }
}

// MARK: - Pawn move
extension Board {
    func canMovePiece(from: Position, to: Position, currentColor: Piece.Color) -> Result<Bool, Board.MoveError> {
        guard let targetPiece = getPieceOnBoard(position: from) else {
            return .failure(.isEmptySpace)
        }
        guard isMyPiece(targetPiece: targetPiece, currentColor: currentColor) else {
            return .failure(.isNotMyPiece)
        }
        guard !isBlockedByMyPiece(targetPiece: targetPiece, to: to) else {
            return .failure(.existSameColorPiece)
        }
        guard isReachablePosition(targetPiece: targetPiece, to: to) else {
            return .failure(.isNotReachable)
        }
        
        return .success(true)
    }
    
    func movePawn(from: Position, to: Position) {
        var pawn = getPieceOnBoard(position: from)
        pawn?.position = to
        setPieceOnBoard(position: to, piece: pawn)
        
        setPieceOnBoard(position: from, piece: nil)
    }
    
    func isMyPiece(targetPiece: Piecable, currentColor: Piece.Color) -> Bool {
        return targetPiece.color == currentColor
    }
    
    func isBlockedByMyPiece(targetPiece: Piecable, to: Position) -> Bool {
        let toPiece = getPieceOnBoard(position: to)
        
        return targetPiece.color == toPiece?.color
    }
    
    func isReachablePosition(targetPiece: Piecable, to: Position) -> Bool {
        let reachablePositions = self.getReachablePositions(targetPiece: targetPiece)
        return reachablePositions.contains(to)
    }
    
    func getReachablePositions(targetPiece: Piecable) -> [Position] {
        switch targetPiece.moveType {
        case .line:
            return self.lineMoveReachablePositions(targetPiece: targetPiece)
        case .dot:
            return self.dotMoveReachablePositions(targetPiece: targetPiece)
        }
    }
    
    func lineMoveReachablePositions(targetPiece: Piecable) -> [Position] {
        var directions = targetPiece.reachableDirections().map { $0.getRawValue() }
        var positions = [Position]()
        
        for step in 1...targetPiece.getMaximumStep() {
            directions = movableDirections(targetPiece: targetPiece, step: step, directions: directions)
            
            directions
                .compactMap { direction in
                    let directionMutiplied = (file: direction.file * step, rank: direction.rank * step)
                    return targetPiece.position.getPosition(rankAdded: directionMutiplied.rank, fileAdded: directionMutiplied.file)
                }
                .forEach { position in
                    positions.append(position)
                }
        }
        return positions
    }

    func movableDirections(
        targetPiece: Piecable,
        step: Int,
        directions: [(file: Int, rank: Int)]
    ) -> [(file: Int, rank: Int)] {
        return directions.compactMap { direction in
            let directionMutiplied = (file: direction.file * step, rank: direction.rank * step)
            
            guard let toPosition = targetPiece.position.getPosition(rankAdded: directionMutiplied.rank, fileAdded: directionMutiplied.file) else {
                return nil
            }
            
            if isBlockedByMyPiece(targetPiece: targetPiece, to: toPosition) {
                return nil
            } else {
                return direction
            }
        }
    }
    
    func dotMoveReachablePositions(targetPiece: Piecable) -> [Position] {
        let positions = targetPiece.reachablePositions().filter { position in
            return !isBlockedByMyPiece(targetPiece: targetPiece, to: position)
        }
        return positions
    }
}


// MARK: - Matrix Common
extension Board {
    func getPieceOnBoard(position: Position) -> Piecable? {
        return matrix[position.rank.rawValue][position.file.rawValue]
    }
    
    @discardableResult
    func setPieceOnBoard(position: Position, piece: Piecable?) -> Bool {
        var newPiece = piece
        newPiece?.position = position
        matrix[position.rank.rawValue][position.file.rawValue] = newPiece
        return true
    }
}
