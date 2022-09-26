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
    var matrix: [[String]]
    
    init() {
        let rank = Array(repeating: ".", count: 8)
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
}

// MARK: - Pawn initialize
extension Board {
    func canSetPawn(pawn: Pawn) -> Bool {
        guard !indexOutOfRange(rank: pawn.position.rank, file: pawn.position.file) else {
            return false
        }
        guard isCorrectRankPosition(piece: pawn) else {
            return false
        }
        guard IsEmptyPosition(position: pawn.position) else {
            return false
        }
        guard !IsOverPawnMaxCount(color: pawn.color) else {
            return false
        }
        
        return true
    }
    
    func isCorrectRankPosition(piece: Piece) -> Bool {
        let rank = piece.position.rank
        
        switch piece.getColor() {
        case .white:
            if rank == 7 || rank == 8 {
                return true
            }
        case .black:
            if rank == 1 || rank == 2 {
                return true
            }
        }
        
        return false
    }
    
    func IsEmptyPosition(position: PiecePosition) -> Bool {
        // piece를 파라미터로 받는게 좋을까?
        let piece = getPieceOnBoard(rank: position.rank, file: position.file)
        
        if piece == "." {
            return true
        } else {
            return false
        }
    }
    
    func IsOverPawnMaxCount(color: PieceColor) -> Bool {
        switch color {
        case .white:
            if theNumberOfWhitePawn() > PawnConst.maxCount {
                return true
            }
        case .black:
            if theNumberOfBlackPawn() > PawnConst.maxCount {
                return true
            }
        }
        return false
    }
    
    func theNumberOfWhitePawn() -> Int {
        var num: Int = 0
        matrix.forEach { ranks in
            ranks.forEach { piece in
                if piece == PawnConst.whiteName {
                    num += 1
                }
            }
        }
        return num
    }
    
    func theNumberOfBlackPawn() -> Int {
        var num: Int = 0
        matrix.forEach { ranks in
            ranks.forEach { piece in
                if piece == PawnConst.blackName {
                    num += 1
                }
            }
        }
        return num
    }
}

// MARK: - Pawn move
extension Board {
    func canMovePawn(from: PiecePosition, to: PiecePosition, currentColor: PieceColor) -> Bool {
        guard !indexOutOfRange(rank: to.rank, file: to.file) else {
            return false
        }
        guard isMyPiece(from: from, currentColor: currentColor) else {
            return false
        }
        guard !existSameColorPiece(from: from, to: to) else {
            return false
        }
        guard isOneStepFoward(from: from, to: to, currentColor: currentColor) else {
            return false
        }
        
        return true
    }
    
    func movePawn(from: PiecePosition, to: PiecePosition, pieceName: String) {
        setPieceOnBoard(position: from, name: ".")
        setPieceOnBoard(position: to, name: pieceName)
    }
    
    func isMyPiece(from: PiecePosition, currentColor: PieceColor) -> Bool {
        guard let fromPiece = getPieceOnBoard(rank: from.rank, file: from.file) else {
            return false
        }
        
        if fromPiece.suffix(1) == currentColor.getSymbolString() {
            return true
        } else {
            return false
        }
    }
    
    func existSameColorPiece(from: PiecePosition, to: PiecePosition) -> Bool {
        let fromPiece = getPieceOnBoard(rank: from.rank, file: from.file)
        let toPiece = getPieceOnBoard(rank: to.rank, file: to.file)
        
        if toPiece?.suffix(1) == fromPiece?.suffix(1) {
            return true
        } else {
            return false
        }
    }
    
    func isOneStepFoward(from: PiecePosition, to: PiecePosition, currentColor: PieceColor) -> Bool {
        if from.file == to.file {
            switch currentColor {
            case .white:
                if (to.rank - from.rank) == -1 {
                    return true
                }
            case .black:
                if (to.rank - from.rank) == 1 {
                    return true
                }
            }
        }
        
        return true
    }
}


// MARK: - Matrix Common
extension Board {
    func getPieceOnBoard(rank: Int, file: Int) -> String? {
        guard rank >= 1 && rank <= 8 && file >= 1 && file <= 8 else {
            return nil
        }
        return matrix[rank - 1][file - 1]
    }
    
    @discardableResult
    func setPieceOnBoard(position: PiecePosition, name: String) -> Bool {
        let rank = position.rank
        let file = position.file
        guard rank >= 1 && rank <= 8 && file >= 1 && file <= 8 else {
            return false
        }
        
        matrix[rank - 1][file - 1] = name
        return true
    }
    
    func indexOutOfRange(rank: Int, file: Int) -> Bool {
        if rank < 1 || rank > 8 || file < 1 || file > 8 {
            return true
        }
        return false
    }
}

// MARK: = Dummy Data
extension Board {
    func setPawnDummyData() {
        for file in 1...8 {
            let position = PiecePosition(rank: PawnConst.blackStartRank, file: file)
            setPieceOnBoard(position: position, name: PawnConst.blackName)
        }
        for file in 1...8 {
            let position = PiecePosition(rank: PawnConst.whiteStartRank, file: file)
            setPieceOnBoard(position: position, name: PawnConst.whiteName)
        }
    }
}
