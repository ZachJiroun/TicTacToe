//
//  StartingViewController.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import UIKit
import Foundation
import ReactiveCocoa

class StartingViewController: UIViewController {
    
    @IBOutlet weak var player1TextField: TextField!
    @IBOutlet weak var player2TextField: TextField!
    @IBOutlet weak var startGameButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startGameButton.enabled = false
        
        // Enables startGameButton when both text fields have text.
        let player1Signal = player1TextField.rac_textSignal()
            .toSignalAssumingHot()
            .assumeNoErrors()
            .map { text in text as! String }
            .map { $0.characters.count > 0 }
        
        let player2Signal = player2TextField.rac_textSignal()
            .toSignalAssumingHot()
            .assumeNoErrors()
            .map { text in text as! String }
            .map { $0.characters.count > 0 }
        
        let signal = combineLatest(player1Signal, player2Signal)
            .map { valid in valid.0 && valid.1 }
        
        startGameButton.rac_enabled <~ signal
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showGame" {
            let gameVM = GameViewModel(player1: self.player1TextField.text!, player2: self.player2TextField.text!)
            let gameVC = segue.destinationViewController as! GameViewController
            gameVC.viewModel = gameVM
        }
    }
    
}