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
    
    private var gameModel: GameModel
    
    init(player1: String, player2: String) {
        
        gameModel = GameModel(player1: player1, player2: player2)
        
        self.player1Name.value = player1
        self.player2Name.value = player2
        self.player1Score.value = getPlayerScore(gameModel.p1)
        self.player2Score.value = getPlayerScore(gameModel.p2)
        
        self.currentPlayersTurnName.value = getPlayerTurn()
        
    }
    
    func getPlayerScore(p: Player) -> String {
        return String(p.score)
    }
    
    func getPlayerTurn() -> String {
        guard let p = gameModel.nextTurn else {
            return "Game Over!"
        }
        return "\(p.name)'s Turn"
    }
    
}