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
        
    }
    
    func possibleToMove(position: Piece.Position) -> [Piece.Position] {
        guard let piece = board.getPieceOnBoard(position: position) else {
            return []
        }
        let reachablePositions = piece.reachablePositions()
        let possiblePositions = reachablePositions
            .filter { position in
                let canMove = board.canMovePiece(
                    from: piece.position,
                    to: position,
                    currentColor: piece.color
                )
                
                switch canMove {
                case .success(_):
                    return true
                case .failure(let error):
                    return false
                }
            }
        
        return possiblePositions
    }
    
    func initializePieces() {
        initializePawn()
        initializeBishop()
        initializeRook()
    }
    
    func initializePawn() {
        initBlackPawn()
        initWhitePawn()
    }
    
    func initializeBishop() {
        initBlackBishop()
        initWhiteBishop()
    }
    
    func initializeRook() {
        initBlackRook()
        initWhiteRook()
    }
    
    func initBlackPawn() {
        File.allCases.forEach { file in
            let pawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: file))
            
            switch board.canSetPiece(piece: pawn) {
            case .success(_):
                board.setPieceOnBoard(position: pawn.position, piece: pawn)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initWhitePawn() {
        File.allCases.forEach { file in
            let pawn = Pawn(color: .white, position: Piece.Position(rank: .seven, file: file))
            
            switch board.canSetPiece(piece: pawn) {
            case .success(_):
                board.setPieceOnBoard(position: pawn.position, piece: pawn)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initBlackBishop() {
        [
            Bishop(color: .black, position: .init(rank: .one, file: .C)),
            Bishop(color: .black, position: .init(rank: .one, file: .F))
        ].forEach { bishop in
            switch board.canSetPiece(piece: bishop) {
            case .success(_):
                board.setPieceOnBoard(position: bishop.position, piece: bishop)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initWhiteBishop() {
        [
            Bishop(color: .white, position: .init(rank: .eight, file: .C)),
            Bishop(color: .white, position: .init(rank: .eight, file: .F))
        ].forEach { bishop in
            switch board.canSetPiece(piece: bishop) {
            case .success(_):
                board.setPieceOnBoard(position: bishop.position, piece: bishop)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initBlackRook() {
        [
            Rook(color: .black, position: .init(rank: .one, file: .A)),
            Rook(color: .black, position: .init(rank: .one, file: .H))
        ].forEach { rook in
            switch board.canSetPiece(piece: rook) {
            case .success(_):
                board.setPieceOnBoard(position: rook.position, piece: rook)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initWhiteRook() {
        [
            Rook(color: .white, position: .init(rank: .eight, file: .A)),
            Rook(color: .white, position: .init(rank: .eight, file: .H))
        ].forEach { rook in
            switch board.canSetPiece(piece: rook) {
            case .success(_):
                board.setPieceOnBoard(position: rook.position, piece: rook)
            case .failure(let error):
                print(error)
            }
        }
    }
}
