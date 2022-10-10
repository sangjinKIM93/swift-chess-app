//
//  PieceButton.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/08.
//

import UIKit

class PieceButton: UIButton {
    let position: Position
    var piece: Piece?
    
    init(position: Position) {
        self.position = position
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func updatePieceData(piece: Piece?) {
        self.piece = piece
        if let piece = piece {
            self.setTitle(piece.getSymbol(), for: .normal)
        } else {
            self.setTitle("", for: .normal)
        }
        
    }
}
