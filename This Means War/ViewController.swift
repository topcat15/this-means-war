//
//  ViewController.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    var game = WarGameLogic()
    
    @IBOutlet weak var battleFieldFirstPlayer: UIImageView!
    @IBOutlet weak var battleFieldSecondPlayer: UIImageView!
    @IBOutlet weak var drawPileFirstPlayer: UIImageView!
    @IBOutlet weak var drawPileSecondPlayer: UIImageView!
    @IBOutlet weak var healPileFirstPlayer: UIImageView!
    @IBOutlet weak var healPileSecondPlayer: UIImageView!
    @IBOutlet weak var scoreLabelFirstPlayer: UILabel!
    @IBOutlet weak var scoreLabelSecondPlayer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawPileFirstPlayer.image = UIImage(named: "back")
        self.drawPileSecondPlayer.image = UIImage(named: "back")
        self.battleFieldFirstPlayer.image = UIImage(named: "outline")
        self.battleFieldSecondPlayer.image = UIImage(named: "outline")
        self.healPileFirstPlayer.image = UIImage(named: "outline")
        self.healPileSecondPlayer.image = UIImage(named: "outline")
        self.scoreLabelFirstPlayer.text = String(game.firstPlayerDeck.count)
        self.scoreLabelSecondPlayer.text = String(game.secondPlayerDeck.count)
    }
    
    func updateScore() {

     scoreLabelFirstPlayer.text = String(game.firstPlayerDeck.count)
     scoreLabelSecondPlayer.text = String(game.secondPlayerDeck.count)
    }
    
    // Reset the image property to "outline" if the [Card] is empty (cardOutlet is the VC equivalent to the model counterpart)
    func resetCardImagesWhenCardArrayIsEmpty(_ arrayOfCards: [Card], _ cardOutlet: UIImageView) {
        
        if arrayOfCards.count == 0 {
            
            cardOutlet.image = UIImage(named: "outline")
        }
    }
    
    @IBAction func moveTopOfDrawToBattleField(_ sender: Any) {
         
        game.moveCardToBattleField()
        
        // Check to see if we need to reset the image for any empty [Card]
        resetCardImagesWhenCardArrayIsEmpty(game.healPileFirstPlayer, healPileFirstPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.healPileSecondPlayer, healPileSecondPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.drawPileFirstPlayer, drawPileFirstPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.drawPileSecondPlayer, drawPileSecondPlayer)
        
        // Show the cards that are moved into the battle field positions
        if game.checkIfArrayOfCardsIsEmpty(game.battleFieldFirstPlayer) == false {

            battleFieldFirstPlayer.image = UIImage(named: "\(game.battleFieldFirstPlayer.first!.image)")
        }
        
        if game.checkIfArrayOfCardsIsEmpty(game.battleFieldSecondPlayer) == false {

            battleFieldSecondPlayer.image = UIImage(named: "\(game.battleFieldSecondPlayer.first!.image)")
        }
    }
    
    // Determine battle winner
    @IBAction func battle(_ sender: Any) {
        
        game.determineBattleWinner()
        
        // Update the images for the heal piles
        if game.winner == "Player 1" {
            
            healPileFirstPlayer.image = UIImage(named: "\(game.healPileFirstPlayer.last!.image)")
        }
        
        if game.winner == "Player 2" {
            
            healPileSecondPlayer.image = UIImage(named: "\(game.healPileSecondPlayer.last!.image)")
        }
        
        // Reset images for battle field positions to the outline
        battleFieldFirstPlayer.image = UIImage(named: "outline")
        battleFieldSecondPlayer.image = UIImage(named: "outline")
        
        // Update the score in the view after the battle
        updateScore()
    }
}
