//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation
import ReactiveCocoa

class GameViewModel {
    
    let currentPlayersTurnName = MutableProperty<String>("")
    let player1Name = MutableProperty<String>("")
    let player2Name = MutableProperty<String>("")
    let player1Score = MutableProperty<String>("")
    let player2Score = MutableProperty<String>("")
    let shouldSwitchColor = MutableProperty<Bool>(false)
    
    private var gameModel: GameModel
    
    init(player1: String, player2: String) {
        
        gameModel = GameModel(player1: player1, player2: player2)
        
        self.player1Name.value = player1
        self.player2Name.value = player2
        self.player1Score.value = getPlayerScore(gameModel.p1)
        self.player2Score.value = getPlayerScore(gameModel.p2)
        
        getPlayerTurn()
    }
    
    func startNewGame() {
        gameModel.resetGame()
        getPlayerTurn()
        shouldSwitchColor.value = true
    }
    
    func isGameOver(p: Player) -> Bool {
        if gameModel.didPlayerWin(p) {
            p.score += 1
            if p.marker == .X {
                self.player1Score.value = getPlayerScore(gameModel.p1)
            } else {
                self.player2Score.value = getPlayerScore(gameModel.p2)
            }
            return true
        } else if gameModel.isDraw() {
            return true
        }
        return false
    }
    
    func getCurrentPlayer() -> Player? {
        return gameModel.currentTurn
    }
    
    func getPlayerScore(p: Player) -> String {
        return String(p.score)
    }
    
    func getPlayerTurn() {
        guard let p = gameModel.currentTurn else {
            currentPlayersTurnName.value = "Game Over!"
            return
        }
        currentPlayersTurnName.value = "\(p.name)'s Turn"
        shouldSwitchColor.value = !shouldSwitchColor.value
    }
    
    // Returns marker if one exists at position, nil if Blank
    func getMarkerAtPosition(space: (Int, Int)) -> Marker? {
        let gridSpace: GridSpace = gameModel.getValueAtSpace(space.0, y: space.1)
        switch gridSpace {
        case .Marked(let m):
            return m
        default:
            return nil
        }
    }
    
    func isSpaceBlank(space: (Int, Int)) -> Bool {
        let space: GridSpace = gameModel.getValueAtSpace(space.0, y: space.1)
        switch space {
        case .Blank:
            return true
        default:
            return false
        }
    }
    
    func makeMove(space: (Int, Int)) {
        let p: Player = gameModel.currentTurn!
        gameModel.markSpace(p.marker, space: space)
        getPlayerTurn()
    }
}