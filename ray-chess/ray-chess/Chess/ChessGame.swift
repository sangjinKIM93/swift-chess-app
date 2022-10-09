//
//  ChessGame.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/26.
//

import Foundation

protocol ChessGameDelegate {
    func targetPieceSelected(piece: Piecable)
    func targetPieceSelectedAgain()
    func targetPieceMoved(matrix: BoardMatrix)
    func enemyPieceTaken(score: (black: Int, white: Int))
    func enemyPieceSelected()
    func turnChanged(turn: Piece.Color)
}

// - 체스판 초기화
// - 출력 전 프로세싱
class ChessGame {

    enum SelectionType {
        case from
        case to(from: Position)
    }
    
    let board = Board()
    var turn: Piece.Color
    var selectionType = SelectionType.from
    
    var delegate: ChessGameDelegate?
    
    init() {
        self.turn = .white
        initializePieces()
        
    }
    
    func processSelection(position: Position) {
        switch selectionType {
        case .from:
            processFirstSelection(position: position)
        case .to(let from):
            processSecondSelection(from: from, to: position)
        }
    }
    
    func processFirstSelection(position: Position) {
        guard let piece = board.getPieceOnBoard(position: position) else {
            return
        }
        guard isMyTurn(color: piece.color) else {
            delegate?.enemyPieceSelected()
            return
        }
        delegate?.targetPieceSelected(piece: piece)
        self.selectionType = .to(from: position)
    }
    
    func processSecondSelection(from: Position, to: Position) {
        if to == from {
            delegate?.targetPieceSelectedAgain()
            self.selectionType = .from
            return
        }
        
        if board.canMovePiece(from: from, to: to, currentColor: self.turn) == .success(true) {
            let isEnemyPieceTaken = isEnemyPiece(position: to)
            
            board.movePawn(from: from, to: to)
            delegate?.targetPieceMoved(matrix: board.matrix)
            if isEnemyPieceTaken {
                delegate?.enemyPieceTaken(score: board.getScore())
            }
            
            turnOver()
        }
    }
    
    func isMyTurn(color: Piece.Color) -> Bool {
        return self.turn == color
    }
    
    func isEnemyPiece(position: Position) -> Bool {
        guard let toPiece = board.getPieceOnBoard(position: position) else {
            return false
        }
        return toPiece.color != turn
    }
    
    func turnOver() {
        self.selectionType = .from
        self.turn = turn.getNext()
        delegate?.turnChanged(turn: self.turn)
    }
    
    func possibleToMove(position: Position) -> [Position] {
        guard let piece = board.getPieceOnBoard(position: position) else {
            return []
        }
        let possiblePositions = board.getReachablePositions(targetPiece: piece)
        
        return possiblePositions
    }
}

// MARK: - initialiaze
extension ChessGame {
    func initializePieces() {
        initializePawn()
        initializeBishop()
        initializeRook()
        initializeQueen()
        initializeKnight()
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
    
    func initializeQueen() {
        [
            Queen(color: .white, position: .init(rank: .eight, file: .E)),
            Queen(color: .black, position: .init(rank: .one, file: .E))
        ].forEach { rook in
            switch board.canSetPiece(piece: rook) {
            case .success(_):
                board.setPieceOnBoard(position: rook.position, piece: rook)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initializeKnight() {
        [
            Knight(color: .white, position: .init(rank: .eight, file: .B)),
            Knight(color: .white, position: .init(rank: .eight, file: .G)),
            Knight(color: .black, position: .init(rank: .one, file: .B)),
            Knight(color: .black, position: .init(rank: .one, file: .G)),
        ].forEach { rook in
            switch board.canSetPiece(piece: rook) {
            case .success(_):
                board.setPieceOnBoard(position: rook.position, piece: rook)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initBlackPawn() {
        Position.File.allCases.forEach { file in
            let pawn = Pawn(color: .black, position: Position(rank: .two, file: file))
            
            switch board.canSetPiece(piece: pawn) {
            case .success(_):
                board.setPieceOnBoard(position: pawn.position, piece: pawn)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func initWhitePawn() {
        Position.File.allCases.forEach { file in
            let pawn = Pawn(color: .white, position: Position(rank: .seven, file: file))
            
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
