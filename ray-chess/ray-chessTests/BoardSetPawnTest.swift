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
//        checkIsOverPawnMaxCount()
    }
    
    func checkGetPiece() {
        let board = Board()
        
        // 존재성 테스트
        XCTAssertEqual(board.matrix.count, 8)
        board.matrix.forEach { rank in
            XCTAssertEqual(rank.count, 8)
        }
        
        // 개체 수 테스트
        XCTAssertEqual(board.getPieceOnBoard(position: Piece.Position(rank: .one, file: .A)) != nil, true)
        XCTAssertEqual(board.getPieceOnBoard(position: Piece.Position(rank: .eight, file: .H)) != nil, true)
        XCTAssertEqual(board.getPieceOnBoard(position: Piece.Position(rank: .two, file: .B)) != nil, true)
    }
    
    func checkSetPiece() {
        let board = Board()
        let onePiece = Piece(color: .white, position: Piece.Position(rank: .one, file: .A), name: "")
        let nPiece = Piece(color: .white, position: Piece.Position(rank: .eight, file: .H), name: "")
        
        XCTAssertEqual(board.setPieceOnBoard(position: onePiece.position, piece: onePiece), true)
        XCTAssertEqual(board.setPieceOnBoard(position: nPiece.position, piece: nPiece), true)
        
    }
    
    func checkIsCorrectRank() {
        let board = Board()
        
        let invalidRankPostionPawn = Pawn(color: .black, position: Piece.Position(rank: .four, file: .A))
        XCTAssertEqual(
            board.canSetPawn(pawn: invalidRankPostionPawn),
            false
        )
        
        let validRankPostionPawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        XCTAssertEqual(
            board.canSetPawn(pawn: validRankPostionPawn),
            true
        )
    }
    
    func checkIsEmptyPosition() {
        let board = Board()
        
        let dummyPawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        XCTAssertEqual(
            board.canSetPawn(pawn: dummyPawn),
            true
        )
        
        board.setPieceOnBoard(position: dummyPawn.position, piece: dummyPawn)
        
        let noEmptySpacePawn = Pawn(color: .black, position: Piece.Position(rank: .two, file: .A))
        
        XCTAssertEqual(
            board.canSetPawn(pawn: noEmptySpacePawn),
            false
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
