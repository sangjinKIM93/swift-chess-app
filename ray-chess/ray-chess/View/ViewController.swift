//
//  ViewController.swift
//  ray-chess
//
//  Created by 김상진 on 2022/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    let chessGame = ChessGame()
    
    let boardView = BoardView()
    let scoreLabel = UILabel()
    let turnLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardView.delegate = self
        chessGame.delegate = self
        
        setupView()
        
        boardView.updateBoard(boardMatrix: chessGame.board.matrix)
    }
    
    func setupView() {
        [boardView, scoreLabel, turnLabel].forEach {
            self.view.addSubview($0)
        }
        
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        boardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        boardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        boardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 30).isActive = true
        scoreLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        turnLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20).isActive = true
        turnLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }

    func updateScoreLabel(white: Int, black: Int) {
        scoreLabel.text = "WhiteScore \(white) : \(black) BlackScore"
    }

    func updateTurnLabel(turn: Piece.Color) {
        turnLabel.text = "Turn: \(turn)"
    }
}

// MARK: - Input
extension ViewController: BoardViewDelegate {
    func selected(position: Position) {
        chessGame.processSelection(position: position)
    }
}

// MARK: - Output
extension ViewController: ChessGameDelegate {
    func targetPieceSelected(piece: Piecable) {
        showTargetPiece(piece: piece)
        showReachablePostions(piece: piece)
    }
    
    // boardView 전체 최신화가 아닌 변경 부분만 최신화 하도록 수정
    func targetPieceMoved(matrix: BoardMatrix) {
        boardView.updateBoard(boardMatrix: matrix)
        boardView.clearChangedColor()
    }
    
    func enemyPieceTaken(score: (black: Int, white: Int)) {
        updateScoreLabel(white: score.white, black: score.black)
    }
    
    func targetPieceSelectedAgain() {
        boardView.clearChangedColor()
    }
    
    func enemyPieceSelected() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func turnChanged(turn: Piece.Color) {
        updateTurnLabel(turn: turn)
    }
    
    private func showTargetPiece(piece: Piecable) {
        boardView.setSelectedColor(position: piece.position)
    }
    
    private func showReachablePostions(piece: Piecable) {
        let reachablePositions = chessGame.board.getReachablePositions(targetPiece: piece)
        reachablePositions.forEach { reachablePosition in
            boardView.setReachableColor(position: reachablePosition)
        }
    }
}
