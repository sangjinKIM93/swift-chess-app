//
//  Position.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/07.
//

import Foundation

struct Position: Equatable {
    var rank: Rank
    var file: File
    
    func getPosition(rankAdded: Int, fileAdded: Int) -> Position? {
        guard let rank = self.rank.getPoint(added: rankAdded),
              let file = self.file.getPoint(added: fileAdded) else {
            return nil
        }
        
        return Position(rank: rank, file: file)
    }
    
    enum File: Int, CaseIterable {
        case A = 0, B, C, D, E, F, G, H
        
        func getPoint(added: Int) -> File? {
            let file = self.rawValue + added
            return File(rawValue: file)
        }
    }

    enum Rank: Int, CaseIterable {
        case one = 0, two, three, four, five, six, seven, eight
        
        func getPoint(added: Int) -> Rank? {
            let rank = self.rawValue + added
            return Rank(rawValue: rank)
        }
    }
}
