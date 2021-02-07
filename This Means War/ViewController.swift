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
    
    // Reset the image property to "outline" if the [Card] is empty (outlet is the VC equivalent to the model counterpart)
    func resetCardImagesWhenCardArrayIsEmpty(_ arrayOfCards: [Card], _ outlet: UIImageView) {
        
        if arrayOfCards.count == 0 {
            
            outlet.image = UIImage(named: "outline")
        }
    }
    
    func setCardImagesWhenCardArrayIsPopulated(_ arrayOfCards: [Card], _ outlet: UIImageView) {
        
        if game.checkIfArrayOfCardsIsEmpty(arrayOfCards) == false {
            
            outlet.image = UIImage(named: "\(arrayOfCards.first!.image)")
        }
    }
    
    func resetDrawPileImageWhenPopulated(_ drawPile: [Card], _ outlet: UIImageView) {
        
        if drawPile.count != 0 {
            
            outlet.image = UIImage(named: "back")
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
        setCardImagesWhenCardArrayIsPopulated(game.battleFieldFirstPlayer, battleFieldFirstPlayer)
        setCardImagesWhenCardArrayIsPopulated(game.battleFieldSecondPlayer, battleFieldSecondPlayer)
    }
    
    // Determine battle winner
    @IBAction func battle(_ sender: Any) {
        
        game.determineBattleWinner()
        
        // Update the images for the heal piles
        if game.winner == "Player 1" {
            
            setCardImagesWhenCardArrayIsPopulated(game.healPileFirstPlayer, healPileFirstPlayer)
        }
        
        if game.winner == "Player 2" {
            
            setCardImagesWhenCardArrayIsPopulated(game.healPileSecondPlayer, healPileSecondPlayer)
        }
        
        resetDrawPileImageWhenPopulated(game.drawPileFirstPlayer, drawPileFirstPlayer)
        resetDrawPileImageWhenPopulated(game.drawPileSecondPlayer, drawPileSecondPlayer)
        
        // Reset images for battle field positions to the outline
        battleFieldFirstPlayer.image = UIImage(named: "outline")
        battleFieldSecondPlayer.image = UIImage(named: "outline")
        
        // Update the score in the view after the battle
        updateScore()
    }
}
