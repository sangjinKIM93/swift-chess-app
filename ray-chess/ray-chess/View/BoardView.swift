//
//  BoardView.swift
//  ray-chess
//
//  Created by 김상진 on 2022/10/08.
//

import UIKit

protocol BoardViewDelegate {
    func selected(position: Position)
}

class BoardView: UIView {

    var matrixView = [[PieceButton]]()

    var delegate: BoardViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        Position.Rank.allCases.forEach { rank in
            let rankStackView = createRankStackView(rank: rank)
            stackView.addArrangedSubview(rankStackView)
        }
    }
    
    func createRankStackView(rank: Position.Rank) -> UIStackView {
        let rankStackView = UIStackView()
        rankStackView.axis = .horizontal
        rankStackView.distribution = .fillEqually
        
        // TODO: 로직 분리
        var pieceButtons = [PieceButton]()
        Position.File.allCases.forEach { file in
            let pieceButton = createPiece(rank: rank, file: file)
            pieceButtons.append(pieceButton)
            rankStackView.addArrangedSubview(pieceButton)
        }
        matrixView.append(pieceButtons)
        
        return rankStackView
    }
    
    func createPiece(rank: Position.Rank, file: Position.File) -> PieceButton {
        let pieceButton = PieceButton(position: .init(rank: rank, file: file))
        pieceButton.addTarget(self, action: #selector(didTapPieceButton(_:)), for: .touchUpInside)
        return pieceButton
    }
    
    func updateBoard(boardMatrix: BoardMatrix) {
        // index 체크
        for (rankRawValue, pieceButtons) in matrixView.enumerated() {
            for (fileRawValue, pieceButton) in pieceButtons.enumerated() {
                let piece = boardMatrix.matrix[rankRawValue][fileRawValue]
                pieceButton.updatePieceData(piece: piece)
            }
        }
    }
    
    func getPieceButton(position: Position) -> PieceButton {
        return matrixView[position.rank.rawValue][position.file.rawValue]
    }
    
    @objc func didTapPieceButton(_ sender: PieceButton) {
        delegate?.selected(position: sender.position)

    }
    
    func setSelectedColor(position: Position) {
        let pieceButton = self.getPieceButton(position: position)
        pieceButton.backgroundColor = .blue
    }
    
    func setReachableColor(position: Position) {
        let pieceButton = self.getPieceButton(position: position)
        pieceButton.backgroundColor = .green
    }
    
    func clearChangedColor() {
        matrixView.forEach { rank in
            rank.forEach { pieceButton in
                pieceButton.backgroundColor = .white
            }
        }
    }
}
