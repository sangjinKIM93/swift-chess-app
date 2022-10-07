//
//  BoardMatrix.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/08.
//

import Foundation

class BoardMatrix {
    private(set) var matrix: [[Piecable?]]
    
    init() {
        let rank = Array<Piecable?>(repeating: nil, count: 8)
        self.matrix = Array(repeating: rank, count: 8)
    }
    
    func getPieceOnMatrix(position: Position) -> Piecable? {
        return matrix[position.rank.rawValue][position.file.rawValue]
    }
    
    func setPieceOnBoard(position: Position, piece: Piecable?) {
        matrix[position.rank.rawValue][position.file.rawValue] = piece
    }
    
    func getScore() -> (black: Int, white: Int) {
        var blackScore = 0
        var whiteScore = 0

        matrix.forEach { rank in
            rank.forEach { piece in
                if let piece = piece {
                    switch piece.color {
                    case .white:
                        whiteScore += piece.point
                    case .black:
                        blackScore += piece.point
                    }
                }
            }
        }
        
        return (blackScore, whiteScore)
    }
    
    func display() -> [[String]] {
        matrix.map { rank -> [String] in
            let formattedRank = rank.map { piece -> String in
                guard let piece = piece else {
                    return "."
                }
                return piece.getSymbol()
            }
            return formattedRank
        }
    }
    
    func theNumberOf(targetPiece: Piecable) -> Int {
        var num: Int = 0
        matrix.forEach { ranks in
            ranks.forEach { piece in
                if piece?.color == targetPiece.color
                    && piece?.name == targetPiece.name {
                    num += 1
                }
            }
        }
        return num
    }
}
