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

    func testExample() throws {
        testGetScore()
    }
    
    func testGetScore() {
        let chessGame = ChessGame()
        let score = chessGame.board.getScore()
        XCTAssertEqual(score.white, 8)
        XCTAssertEqual(score.black, 8)
    }
}
