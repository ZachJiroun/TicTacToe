//
//  GameModel.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/12/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation

typealias GameBoard = [[GridSpace]]

// Represents a Marker (X or O)
enum Marker: Equatable {
    case X
    case O
}

// Represents a space on the tic-tac-toe grid (blank or containing a marker)
enum GridSpace: Equatable {
    case Blank
    case Marked(Marker)
}

// Compares contents of grid spaces for equality
func == (lhs: GridSpace, rhs: GridSpace) -> Bool {
    switch (lhs, rhs) {
    case (.Blank, .Blank):
        return true
    case (.Marked(let lm), .Marked(let rm)):
        return lm == rm
    default:
        return false
    }
}

class GameModel {
    
    var p1: Player
    var p2: Player
    var board: GameBoard
    
    init(player1: String, player2: String) {
        p1 = Player(name: player1, marker: .X)
        p2 = Player(name: player2, marker: .O)
        board = GameModel.newGameBoard()
    }
    
    // Resets the game board
    func resetGame() {
        board = GameModel.newGameBoard()
    }
    
    // Returns the player that has the current turn, nil if board is full
    var currentTurn: Player? {
        get {
            let spaces = board.flatMap{ $0 }
            
            // Check if all spaces contain a marker
            if spaces.count == (spaces.filter { s in s != GridSpace.Blank }).count {
                return nil
            }
            
            let numXMarkers = spaces.filter { $0 == GridSpace.Marked(.X) }.count
            let numOMarkers = spaces.filter { $0 == GridSpace.Marked(.O) }.count
            
            if numXMarkers > numOMarkers {
                return p2
            } else {
                return p1
            }
        }
    }
    
    // Check if all spaces contain a marker
    func isDraw() -> Bool {
        let spaces = board.flatMap{ $0 }
        if spaces.count == (spaces.filter { s in s != GridSpace.Blank }).count {
            return true
        }
        return false
    }
    
    // Returns the Gridspace at the given space
    func getValueAtSpace(x: Int, y: Int) -> GridSpace {
        return board[x][y]
    }
    
    // Creates a 3x3 array of GridSpaces
    private class func newGameBoard() -> GameBoard {
        let gridSpaces = [GridSpace](count: 9, repeatedValue: GridSpace.Blank)
        return gridSpaces.chunk(3)
    }
    
    // Checks rows, columns, and diagonals for 3 in a row
    func didPlayerWin(p: Player) -> Bool {
        let m = p.marker
        return checkRows(m, b: board) || checkColumns(m) || checkDiagonals(m)
    }
    
    // Check horizontally for 3 of a kind marker
    func checkRows(m: Marker, b:GameBoard) ->  Bool {
        for row in b {
            // If the row contains all of the same, find out what the contents are
            if allEqual(row) {
                if let rowMarker = row.first {
                    switch rowMarker {
                    case GridSpace.Marked(let m1):
                        return m == m1
                    default:
                        return false
                    }
                }
            }
        }
        return false
    }
    
    // Check vertically for 3 of a kind marker
    func checkColumns(m: Marker) -> Bool {
        // Flip rows and cols, then use checkRows
        let flippedBoard = flipArray(board)
        return checkRows(m, b: flippedBoard)
    }
    
    // Check diagonaly for 3 of a kind marker
    func checkDiagonals(m: Marker) -> Bool {
        // Check left-to-right diagonal
        if board[0][0] == board[1][1] {
            if board[1][1] == board[2][2] {
                switch board[0][0] {
                case GridSpace.Marked(let m1):
                    return m == m1
                default:
                    return false
                }
            }
        }
        // Check right-to-left diagonal
        if board[2][0] == board[1][1] {
            if board[0][2] == board[1][1] {
                switch board[2][0] {
                case GridSpace.Marked(let m1):
                    return m == m1
                default:
                    return false
                }
            }
        }
        return false
    }
    
    // Marks a space on the board. Returns true if successful, false if space is already marked
    func markSpace(m: Marker, space: (Int, Int)) -> Bool {
        // Space already has a marker
        if board[space.0][space.1] != GridSpace.Blank {
            return false
        }
        
        board[space.0][space.1] = GridSpace.Marked(m)
        
        return true
    }
}