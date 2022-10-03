//
//  ray_chessTests.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/09/24.
//

import XCTest
@testable import ray_chess

class BoardSetPieceTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testCanSetPawn() {
        let board = Board()
        
        let pawn = Pawn(color: .black, position: .init(rank: .four, file: .A))
        XCTAssertEqual(
            board.canSetPiece(piece: pawn),
            .failure(.wrongInitRank)
        )
        
        let rook = Rook(color: .black, position: .init(rank: .two, file: .A))
        XCTAssertEqual(
            board.canSetPiece(piece: rook),
            .failure(.wrongInitRank)
        )
        
        board.setPieceOnBoard(position: pawn.position, piece: pawn)
        
        let noEmptySpacePawn = Pawn(color: .black, position: .init(rank: .two, file: .A))
        
        XCTAssertEqual(
            board.canSetPiece(piece: noEmptySpacePawn),
            .failure(.isFulledPosition)
        )
    }
    
    func testIsCorrectRank() {
        let board = Board()
        
        let wrongPawn = Pawn(color: .white, position: .init(rank: .eight, file: .B))
        let correctPawn = Pawn(color: .white, position: .init(rank: .seven, file: .B))
        XCTAssertEqual(board.isCorrectRankPosition(piece: wrongPawn), false)
        XCTAssertEqual(board.isCorrectRankPosition(piece: correctPawn), true)
        
        let wrongRook = Rook(color: .white, position: .init(rank: .seven, file: .A))
        let correctRook = Rook(color: .white, position: .init(rank: .eight, file: .A))
        XCTAssertEqual(board.isCorrectRankPosition(piece: wrongRook), false)
        XCTAssertEqual(board.isCorrectRankPosition(piece: correctRook), true)
        
        let wrongBishop = Bishop(color: .black, position: .init(rank: .eight, file: .C))
        let correctBishop = Bishop(color: .black, position: .init(rank: .one, file: .C))
        XCTAssertEqual(board.isCorrectRankPosition(piece: wrongBishop), false)
        XCTAssertEqual(board.isCorrectRankPosition(piece: correctBishop), true)
    }
    
    func testIsEmptyPosition() {
        let board = Board()

        let pawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        XCTAssertEqual(
            board.IsEmptyPosition(position: pawn.position),
            true
        )
        board.setPieceOnBoard(position: pawn.position, piece: pawn)
        
        XCTAssertEqual(
            board.IsEmptyPosition(position: pawn.position),
            false
        )
    }
    
    func testIsOverMaxCount() {
        let chessGame = ChessGame()
        chessGame.initializePieces()
        
        let pawn = Pawn(color: .white, position: .init(rank: .seven, file: .A))
        XCTAssertEqual(
            chessGame.board.IsOverPieceMaxCount(piece: pawn),
            true
        )
        let bishop = Bishop(color: .white, position: .init(rank: .seven, file: .A))
        XCTAssertEqual(
            chessGame.board.IsOverPieceMaxCount(piece: bishop),
            true
        )
        let rook = Rook(color: .white, position: .init(rank: .seven, file: .A))
        XCTAssertEqual(
            chessGame.board.IsOverPieceMaxCount(piece: rook),
            true
        )
    }
}
