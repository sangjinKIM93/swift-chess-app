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

    func testExample() throws {
        checkGetPiece()
        checkSetPiece()
        checkCanSetPawn()
    }

    func checkCanSetPawn() {
        checkIsCorrectRank()
        checkIsEmptyPosition()
//        checkIsOverPawnMaxCount()
    }
    
    func checkGetPiece() {
        let board = Board()
        
        // 존재성 테스트
        XCTAssertEqual(board.matrix.count, 8)
        board.matrix.forEach { rank in
            XCTAssertEqual(rank.count, 8)
        }
    }
    
    func checkSetPiece() {
        let board = Board()
        let onePiece = Pawn(color: .white, position: Piece.Position(rank: .one, file: .A))
        let nPiece = Pawn(color: .white, position: Piece.Position(rank: .eight, file: .H))
        
        XCTAssertEqual(board.setPieceOnBoard(position: onePiece.position, piece: onePiece), true)
        XCTAssertEqual(board.setPieceOnBoard(position: nPiece.position, piece: nPiece), true)
        
    }
    
    func checkIsCorrectRank() {
        let board = Board()
        
        let invalidRankPostionPawn = Pawn(color: .black, position: Piece.Position(rank: .four, file: .A))
        XCTAssertEqual(
            board.canSetPiece(piece: invalidRankPostionPawn),
            .failure(.wrongInitRank)
        )
        
        let validRankPostionPawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        XCTAssertEqual(
            board.canSetPiece(piece: validRankPostionPawn),
            .success(true)
        )
    }
    
    func checkIsEmptyPosition() {
        let board = Board()
        
        let dummyPawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        XCTAssertEqual(
            board.canSetPiece(piece: dummyPawn),
            .success(true)
        )
        
        board.setPieceOnBoard(position: dummyPawn.position, piece: dummyPawn)
        
        let noEmptySpacePawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        
        XCTAssertEqual(
            board.canSetPiece(piece: noEmptySpacePawn),
            .failure(.isFulledPosition)
        )
    }
    
//    func checkIsOverPawnMaxCount() {
//        let board = Board()
//
//        for i in 1...9 {
//            let pawn = Pawn(color: .black, position: Piece.Position(rank: 2, file: i))
//            if i > 8 {
//                XCTAssertEqual(
//                    board.canSetPawn(pawn: pawn),
//                    false
//                )
//            } else {
//                XCTAssertEqual(
//                    board.canSetPawn(pawn: pawn),
//                    true
//                )
//            }
//            board.setPieceOnBoard(position: pawn.position, name: pawn.name)
//        }
//    }
}
