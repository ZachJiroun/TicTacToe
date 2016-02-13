//
//  Player.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/12/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation

// Represents a player
struct Player {
    let name: String
    let marker: Marker
    var score: Int
    
    init(name: String, marker: Marker) {
        self.name = name
        self.marker = marker
        self.score = 0
    }
}