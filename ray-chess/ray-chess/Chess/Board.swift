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
    
    func showScore() {
        //
    }
    
    func display() {
        matrix.forEach { rank in
            print(rank)
        }
    }
    
    enum ErrorCase: Error {
        case isEmptySpace
        case wrongInitRank
        case isFulledPosition
        case isOverMaxCount
    }
}

// MARK: - Pawn initialize
extension Board {
    func canSetPawn(pawn: Pawn) -> Result<Bool, Board.ErrorCase> {
        guard isCorrectRankPosition(piece: pawn) else {
            return .failure(.wrongInitRank)
        }
        guard IsEmptyPosition(position: pawn.position) else {
            return .failure(.isFulledPosition)
        }
        guard !IsOverPieceMaxCount(piece: pawn) else {
            return .failure(.isOverMaxCount)
        }
        
        return .success(true)
    }
    
    func isCorrectRankPosition(piece: Piecable) -> Bool {
        return piece.isInitializableRank()
    }
    
    func IsEmptyPosition(position: Piece.Position) -> Bool {
        let piece = getPieceOnBoard(position: position)
        
        return piece == nil
    }
    
    func IsOverPieceMaxCount(piece: Piecable) -> Bool {
        let numberOfPiece = theNumberOf(targetPiece: piece)
        
        return numberOfPiece > piece.maxCount
    }
    
    func theNumberOf(targetPiece: Piecable) -> Int {
        var num: Int = 0
        matrix.forEach { ranks in
            ranks.forEach { piece in
                if piece?.color == targetPiece.color
                    || piece?.name == targetPiece.name {
                    num += 1
                }
            }
        }
        return num
    }
}

// MARK: - Pawn move
extension Board {
    func canMovePawn(from: Piece.Position, to: Piece.Position, currentColor: Piece.Color) -> Bool {
        guard isMyPiece(from: from, currentColor: currentColor) else {
            return false
        }
        guard !existSameColorPiece(from: from, to: to) else {
            return false
        }
        guard isReachablePosition(from: from, to: to, currentColor: currentColor) else {
            return false
        }
        
        return true
    }
    
    func movePawn(from: Piece.Position, to: Piece.Position) {
        var pawn = getPieceOnBoard(position: from)
        pawn?.position = to
        setPieceOnBoard(position: to, piece: pawn)
        
        setPieceOnBoard(position: from, piece: nil)
    }
    
    func isMyPiece(from: Piece.Position, currentColor: Piece.Color) -> Bool {
        guard let fromPiece = getPieceOnBoard(position: from) else {
            return false
        }
        
        return fromPiece.color == currentColor
    }
    
    func existSameColorPiece(from: Piece.Position, to: Piece.Position) -> Bool {
        let fromPiece = getPieceOnBoard(position: from)
        let toPiece = getPieceOnBoard(position: to)
        
        return fromPiece?.color == toPiece?.color
    }
    
    func isReachablePosition(from: Piece.Position, to: Piece.Position, currentColor: Piece.Color) -> Bool {
        guard let piece = getPieceOnBoard(position: from) else {
            return false
        }
        
        return piece.reachablePosition().contains(to)
    }
}


// MARK: - Matrix Common
extension Board {
    func getPieceOnBoard(position: Piece.Position) -> Piecable? {
        return matrix[position.rank.rawValue][position.file.rawValue]
    }
    
    @discardableResult
    func setPieceOnBoard(position: Piece.Position, piece: Piecable?) -> Bool {
        matrix[position.rank.rawValue][position.file.rawValue] = piece
        return true
    }
}
