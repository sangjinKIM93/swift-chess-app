//
//  BoardBasicTest.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/10/02.
//

import XCTest
@testable import ray_chess

class BoardBasicTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testBoard_Score_Pawn_and_Rook_초기화상태_점수() {
        let chessGame = ChessGame()
        chessGame.initializePawn()
        chessGame.initializeRook()
        let score = chessGame.board.getScore()
        XCTAssertEqual(score.white, 18)
        XCTAssertEqual(score.black, 18)
    }
}
