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
        
        let firstResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, true)
        
        let secondResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .white
        )
        XCTAssertEqual(secondResult, false)
    }
    
    func checkExistSameColorPiece() {
        let chessGame = ChessGame()
        
        let firstResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, true)
        
        chessGame.board.movePawn(
            from: PiecePosition(rank: 3, file: 2),
            to: PiecePosition(rank: 6, file: 2),
            pieceName: PawnConst.blackName
        )
        
        let secondResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 6, file: 2),
            to: PiecePosition(rank: 7, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(secondResult, true)
    }
    
    func isOneStepFoward() {
        let chessGame = ChessGame()
        
        let firstResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, true)
        
        let secondResult = chessGame.board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 1, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(secondResult, false)
    }
}
