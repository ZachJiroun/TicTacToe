//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/11/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation
import ReactiveCocoa

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var currentPlayersTurnName: UILabel!
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    var viewModel: GameViewModel?
    @IBOutlet weak var ticTacToeGrid: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ticTacToeGrid.dataSource = self
        ticTacToeGrid.delegate = self
        
        bindViewModel()
    }
    
    func bindViewModel() {
        currentPlayersTurnName.rac_text <~ viewModel!.currentPlayersTurnName
        player1Name.rac_text <~ viewModel!.player1Name
        player2Name.rac_text <~ viewModel!.player2Name
        player1Score.rac_text <~ viewModel!.player1Score
        player2Score.rac_text <~ viewModel!.player2Score
    }
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let position = (indexPath.row, indexPath.section)
        if viewModel!.isSpaceBlank(position) {
            let player = viewModel!.getCurrentPlayer()
            viewModel!.makeMove(position)
            refreshBoard()
            if viewModel!.isGameOver(player) {
                showAlert()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = ticTacToeGrid.dequeueReusableCellWithReuseIdentifier("TicTacToeGridCell", forIndexPath: indexPath) as! TicTacToeGridCell
        
        let position = (indexPath.row, indexPath.section)
        
        // Reset any reused cell's contents to nil
        cell.markerImage.image = nil
        
        if let m = viewModel!.getMarkerAtPosition(position) {
            cell.markerImage.image = UIImage(named: "\(m)")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 1, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    // MARK: Helpers
    
    func refreshBoard() {
        dispatch_async(dispatch_get_main_queue(), {
            self.ticTacToeGrid.reloadData()
        })
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Game Over!", message: "Would you like to play again?", preferredStyle: .Alert)
        let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: { Void in
            self.viewModel!.startNewGame()
            self.refreshBoard()
        })
        let noAction = UIAlertAction(title: "No", style: .Cancel, handler: { Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}