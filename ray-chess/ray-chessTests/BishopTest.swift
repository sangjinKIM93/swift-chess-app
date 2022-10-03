//
//  BishopTest.swift
//  ray-chessTests
//
//  Created by 김상진 on 2022/10/03.
//

import XCTest
@testable import ray_chess

class BishopTest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testExample() throws {
        testReachablePostion()
    }
    
    func testReachablePostion() {
        let bishop = Bishop(color: .white, position: Piece.Position(rank: .five, file: .D))
        
        var result = bishop.reachablePosition()
        var expectedResult = [
            Piece.Position(rank: .eight, file: .A),
            Piece.Position(rank: .two, file: .A),
            Piece.Position(rank: .seven, file: .B),
            Piece.Position(rank: .three, file: .B),
            Piece.Position(rank: .six, file: .C),
            Piece.Position(rank: .four, file: .C),
            Piece.Position(rank: .six, file: .E),
            Piece.Position(rank: .four, file: .E),
            Piece.Position(rank: .seven, file: .F),
            Piece.Position(rank: .three, file: .F),
            Piece.Position(rank: .eight, file: .G),
            Piece.Position(rank: .two, file: .G),
            Piece.Position(rank: .one, file: .H)
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
