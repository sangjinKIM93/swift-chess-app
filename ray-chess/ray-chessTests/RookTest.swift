//
//  RookTest.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/10/03.
//

import XCTest
@testable import ray_chess

class RookTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {
        testReachablePositions()
    }
    
    func testReachablePositions() {
        let bishop = Rook(color: .white, position: Piece.Position(rank: .five, file: .D))
        
        var result = bishop.reachablePositions()
        var expectedResult = [
            Piece.Position(rank: .five, file: .A),
            Piece.Position(rank: .five, file: .B),
            Piece.Position(rank: .five, file: .C),
            Piece.Position(rank: .five, file: .E),
            Piece.Position(rank: .five, file: .F),
            Piece.Position(rank: .five, file: .G),
            Piece.Position(rank: .five, file: .H),
            Piece.Position(rank: .one, file: .D),
            Piece.Position(rank: .two, file: .D),
            Piece.Position(rank: .three, file: .D),
            Piece.Position(rank: .four, file: .D),
            Piece.Position(rank: .six, file: .D),
            Piece.Position(rank: .seven, file: .D),
            Piece.Position(rank: .eight, file: .D)
        ]
        
        result.sort { lhs, rhs in
            (lhs.rank.rawValue, lhs.file.rawValue) > (rhs.rank.rawValue, rhs.file.rawValue)
        }
        expectedResult.sort { lhs, rhs in
            (lhs.rank.rawValue, lhs.file.rawValue) > (rhs.rank.rawValue, rhs.file.rawValue)
        }
        
        XCTAssertEqual(result, expectedResult)
    }
}
