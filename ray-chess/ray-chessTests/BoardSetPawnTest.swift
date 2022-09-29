//
//  ray_chessTests.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/09/24.
//

import XCTest
@testable import ray_chess

class BoardSetPawnTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {
        checkGetPiece()
        checkSetPiece()
        checkCanSetPawn()
    }

    func checkCanSetPawn() {
        checkIsCorrectRank()
        checkIsEmptyPosition()
        checkIsOverPawnMaxCount()
    }
    
    func checkGetPiece() {
        let board = Board()
        
        // 존재성 테스트
        XCTAssertEqual(board.matrix.count, 8)
        board.matrix.forEach { rank in
            XCTAssertEqual(rank.count, 8)
        }
        
        // 개체 수 테스트
        XCTAssertEqual(board.getPieceOnBoard(rank: 0, file: 0), nil)
        XCTAssertEqual(board.getPieceOnBoard(rank: 1, file: 1) != nil, true)
        XCTAssertEqual(board.getPieceOnBoard(rank: 9, file: 9), nil)
        XCTAssertEqual(board.getPieceOnBoard(rank: 8, file: 8) != nil, true)
        XCTAssertEqual(board.getPieceOnBoard(rank: 2, file: 2) != nil, true)
    }
    
    func checkSetPiece() {
        let board = Board()
        let zeroPiece = Piece(color: .white, position: PiecePosition(rank: 0, file: 0), name: "")
        let onePiece = Piece(color: .white, position: PiecePosition(rank: 1, file: 1), name: "")
        let nPiece = Piece(color: .white, position: PiecePosition(rank: 8, file: 8), name: "")
        
        XCTAssertEqual(board.setPieceOnBoard(position: zeroPiece.position, name: zeroPiece.name), false)
        XCTAssertEqual(board.setPieceOnBoard(position: onePiece.position, name: onePiece.name), true)
        XCTAssertEqual(board.setPieceOnBoard(position: nPiece.position, name: nPiece.name), true)
        
    }
    
    func checkIsCorrectRank() {
        let board = Board()
        
        let invalidRankPostionPawn = Pawn(color: .black, position: PiecePosition(rank: 4, file: 1))
        XCTAssertEqual(
            board.canSetPawn(pawn: invalidRankPostionPawn),
            false
        )
        
        let validRankPostionPawn = Pawn(color: .black, position: PiecePosition(rank: 2, file: 1))
        XCTAssertEqual(
            board.canSetPawn(pawn: validRankPostionPawn),
            true
        )
    }
    
    func checkIsEmptyPosition() {
        let board = Board()
        
        let dummyPawn = Pawn(color: .black, position: PiecePosition(rank: 2, file: 1))
        XCTAssertEqual(
            board.canSetPawn(pawn: dummyPawn),
            true
        )
        
        board.setPieceOnBoard(position: dummyPawn.position, name: dummyPawn.name)
        
        let noEmptySpacePawn = Pawn(color: .black, position: PiecePosition(rank: 2, file: 1))
        
        XCTAssertEqual(
            board.canSetPawn(pawn: noEmptySpacePawn),
            false
        )
    }
    
    func checkIsOverPawnMaxCount() {
        let board = Board()
        
        for i in 1...9 {
            let pawn = Pawn(color: .black, position: PiecePosition(rank: 2, file: i))
            if i > 8 {
                XCTAssertEqual(
                    board.canSetPawn(pawn: pawn),
                    false
                )
            } else {
                XCTAssertEqual(
                    board.canSetPawn(pawn: pawn),
                    true
                )
            }
            board.setPieceOnBoard(position: pawn.position, name: pawn.name)
        }
    }
}
