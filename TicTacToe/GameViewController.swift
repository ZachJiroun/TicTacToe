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
        return 9
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = ticTacToeGrid.dequeueReusableCellWithReuseIdentifier("TicTacToeGridCell", forIndexPath: indexPath) as! TicTacToeGridCell
        
        cell.markerImage.image = UIImage(named: "X")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
}