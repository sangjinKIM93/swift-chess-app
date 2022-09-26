//
//  ChessGame.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/26.
//

import Foundation

// - 체스판 초기화
// - 입/출력 관리
class ChessGame {
    
    let board = Board()
    
    init() {
        self.initBlackPawn()
        self.initWhitePawn()
    }
    
    func initBlackPawn() {
        for file in 1...PawnConst.maxCount {
            let pawn = Pawn(color: .black, position: PiecePosition(rank: PawnConst.blackStartRank, file: file))
            
            if board.canSetPawn(pawn: pawn) {
                board.setPieceOnBoard(position: pawn.position, name: pawn.name)
            }
        }
    }
    
    func initWhitePawn() {
        for file in 1...PawnConst.maxCount {
            let pawn = Pawn(color: .white, position: PiecePosition(rank: PawnConst.whiteStartRank, file: file))
            
            if board.canSetPawn(pawn: pawn) {
                board.setPieceOnBoard(position: pawn.position, name: pawn.name)
            }
        }
    }
    
}
