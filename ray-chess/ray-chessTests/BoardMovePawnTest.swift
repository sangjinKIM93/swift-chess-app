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
        let board = Board()
        board.setPawnDummyData()
        
        let firstResult = board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, true)
        
        let secondResult = board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .white
        )
        XCTAssertEqual(secondResult, false)
    }
    
    func checkExistSameColorPiece() {
        let board = Board()
        board.setPawnDummyData()
        
        let firstResult = board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .white
        )
        XCTAssertEqual(firstResult, false)
    }
    
    func isOneStepFoward() {
        let board = Board()
        board.setPawnDummyData()
        
        let firstResult = board.canMovePawn(
            from: PiecePosition(rank: 2, file: 2),
            to: PiecePosition(rank: 3, file: 2),
            currentColor: .black
        )
        XCTAssertEqual(firstResult, true)
    }
}
