//
//  PawnMoveTest.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/09/26.
//

import XCTest
@testable import ray_chess

class BoardMovePawnTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {
        checkCanMovePawn()
    }

    func checkCanMovePawn() {
        checkIsMyPiece()
        checkExistSameColorPiece()
        isOneStepFoward()
    }
    
    func checkIsMyPiece() {
        let chessGame = ChessGame()
        
        let firstResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .three, file: .B),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, .success(true))
        
        let secondResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .three, file: .B),
            currentColor: .white
        )
        XCTAssertEqual(secondResult, .failure(.isNotMyPiece))
    }
    
    func checkExistSameColorPiece() {
        let chessGame = ChessGame()
        
        let firstResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .three, file: .B),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, .success(true))
        
        chessGame.board.movePawn(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .six, file: .B)
        )
        
        let secondResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .six, file: .B),
            to: Piece.Position(rank: .seven, file: .B),
            currentColor: .black
        )
        XCTAssertEqual(secondResult, .success(true))
    }
    
    func isOneStepFoward() {
        let chessGame = ChessGame()
        
        let firstResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .three, file: .B),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, .success(true))
        
        let secondResult = chessGame.board.canMovePiece(
            from: Piece.Position(rank: .two, file: .B),
            to: Piece.Position(rank: .one, file: .B),
            currentColor: .black
        )
        XCTAssertEqual(secondResult, .failure(.isNotReachable))
    }
}
