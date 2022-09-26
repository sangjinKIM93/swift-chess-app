//
//  Array+ext.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/26.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
