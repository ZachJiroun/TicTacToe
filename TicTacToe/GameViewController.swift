//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation
import ReactiveCocoa

class GameViewController: UIViewController {
    
    @IBOutlet weak var currentPlayersTurnName: UILabel!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    var viewModel: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        currentPlayersTurnName.rac_text <~ viewModel!.currentPlayersTurnName
        player1Name.rac_text <~ viewModel!.player1Name
        player2Name.rac_text <~ viewModel!.player2Name
        player1Score.rac_text <~ viewModel!.player1Score
        player2Score.rac_text <~ viewModel!.player2Score
    }
}