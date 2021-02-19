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
    @IBOutlet weak var drawPileTopFirstPlayer: UIImageView!
    @IBOutlet weak var drawPileFirstPlayer: UIImageView!
    @IBOutlet weak var drawPileTopSecondPlayer: UIImageView!
    @IBOutlet weak var drawPileSecondPlayer: UIImageView!
    @IBOutlet weak var healPileFirstPlayer: UIImageView!
    @IBOutlet weak var healPileSecondPlayer: UIImageView!
    @IBOutlet weak var scoreLabelFirstPlayer: UILabel!
    @IBOutlet weak var scoreLabelSecondPlayer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.drawPileTopFirstPlayer.image = UIImage(named: "back")
        self.drawPileTopSecondPlayer.image = UIImage(named: "back")
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
        if arrayOfCards.isEmpty {
            outlet.image = UIImage(named: "outline")
        }
    }
    
    // Check to see if we need to reset the image for any empty [Card]
    func resetDrawAndHealImages() {
        resetCardImagesWhenCardArrayIsEmpty(game.healPileFirstPlayer, healPileFirstPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.healPileSecondPlayer, healPileSecondPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.drawPileFirstPlayer, drawPileFirstPlayer)
        resetCardImagesWhenCardArrayIsEmpty(game.drawPileSecondPlayer, drawPileSecondPlayer)
    }
  
    // Translate and scale the top card of the draw pile into the battle field
    func animateMoveDrawPileTopToBattleField() {
        UIView.animate(withDuration: 0.4, animations: {
            self.drawPileTopFirstPlayer.center = CGPoint(x: 207, y: 544)
            self.drawPileTopFirstPlayer.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self.drawPileTopSecondPlayer.center = CGPoint(x: 207, y: 354)
            self.drawPileTopSecondPlayer.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        })
    }
    
    // Translate and scale the images representing the battle field into the winning team's heal pile
    func animateMoveBattleCardsToWinningHealPile() {
        if game.roundWinner == "Player 1" {
            UIView.animate(withDuration: 0.75, animations: {
                self.battleFieldFirstPlayer.center = CGPoint(x: 317.5, y: 527)
                self.battleFieldFirstPlayer.transform = CGAffineTransform(scaleX: 94/169, y: 94/169)
                self.battleFieldSecondPlayer.center = CGPoint(x: 317.5, y: 527)
                self.battleFieldSecondPlayer.transform = CGAffineTransform(scaleX: 94/169, y: 94/169)
            })
        }
        else if game.roundWinner == "Player 2" {
            UIView.animate(withDuration: 0.75, animations: {
                self.battleFieldFirstPlayer.center = CGPoint(x: 16.5, y: -152)
                self.battleFieldFirstPlayer.transform = CGAffineTransform(scaleX: 94/169, y: 94/169)
                self.battleFieldSecondPlayer.center = CGPoint(x: 16.5, y: -152)
                self.battleFieldSecondPlayer.transform = CGAffineTransform(scaleX: 94/169, y: 94/169)
            })
        }
    }
    
    // The timing is such that you don't see this occur between setBattleFieldCardImagesToBack() and flipBattleFieldPlayerCardToFront()
    func moveDrawPileTopsBackToOriginalPostions() {
        UIView.animate(withDuration: 0, animations: {
            self.drawPileTopFirstPlayer.center = CGPoint(x: 207, y: 772)
            self.drawPileTopFirstPlayer.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.drawPileTopSecondPlayer.center = CGPoint(x: 207, y: 138)
            self.drawPileTopSecondPlayer.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func setCardArrayImageToBack(_ outlet: UIImageView) {
        UIView.transition(with: outlet,
                          duration: 0,
                          options: .transitionCrossDissolve,
                          animations: {
                            outlet.image = UIImage(named: "back")
                          }, completion: nil)
    }
    
    // This happens just as (or right after) the top card from the draw pile animates into this position (so you don't see this happen)
    func setBattleFieldCardImagesToBack() {
        setCardArrayImageToBack(battleFieldFirstPlayer)
        setCardArrayImageToBack(battleFieldSecondPlayer)
    }
    
    // Soon after that the card flips to the front (player 2's card flips in the opposite direction)
    func flipBattleFieldPlayerCardToFront(_ outlet: UIImageView) {
        if outlet == battleFieldFirstPlayer {
            UIView.transition(with: battleFieldFirstPlayer,
                              duration: 0.5,
                              options: .transitionFlipFromTop,
                              animations: {
                                self.battleFieldFirstPlayer.image = UIImage(named: "\(self.game.battleFieldFirstPlayer.first!.imageName)")
                              }, completion: nil)
        }
        else {
            UIView.transition(with: battleFieldSecondPlayer,
                              duration: 0.5,
                              options: .transitionFlipFromBottom,
                              animations: {
                                self.battleFieldSecondPlayer.image = UIImage(named: "\(self.game.battleFieldSecondPlayer.first!.imageName)")
                              }, completion: nil)
        }
    }
    
    // Set the images for Battle Field poistion or a Heal Pile (using firstOrLast like a boolean)
    func setCardImagesWhenCardArrayIsPopulated(_ arrayOfCards: [Card], _ outlet: UIImageView, _ firstOrLast: String) {
        if arrayOfCards.isEmpty == false {
            // Set the image of a Battle Field position
            if firstOrLast == "First" {
                flipBattleFieldPlayerCardToFront(outlet)
            }
            // Set the image of a Heal Pile
            else if firstOrLast == "Last" {
                outlet.image = UIImage(named: "\(arrayOfCards.last!.imageName)")
            }
        }
    }
    
    func resetDrawPileImageWhenPopulated(_ drawPile: [Card], _ outlet: UIImageView) {
        if drawPile.count > 0 {
            outlet.image = UIImage(named: "back")
        }
    }
    
    func resetBattleFieldImagesAfterFirstPlayerVictory() {
        // Reset images for battle field positions to the outline
        self.battleFieldFirstPlayer.image = UIImage(named: "outline")
        self.battleFieldSecondPlayer.image = UIImage(named: "outline")
        // Move battle field positions back to their original places in the view
        UIView.animate(withDuration: 0, animations: {
            self.battleFieldFirstPlayer.transform = CGAffineTransform(translationX: -150.5, y: -253.5)
            self.battleFieldSecondPlayer.transform = CGAffineTransform(translationX: -150.5, y: -442.5)
        })
    }
    
    func resetBattleFieldImagesAfterSecondPlayerVictory() {
        self.battleFieldFirstPlayer.image = UIImage(named: "outline")
        self.battleFieldSecondPlayer.image = UIImage(named: "outline")
        UIView.animate(withDuration: 0, animations: {
            self.battleFieldFirstPlayer.transform = CGAffineTransform(translationX: 150.5, y: 425.5)
            self.battleFieldSecondPlayer.transform = CGAffineTransform(translationX: 150.5, y: 236.5)
        })
    }
    
    @IBAction func moveTopOfDrawToBattleField(_ sender: Any) {
        game.moveCardToBattleFieldIfGameNotOver()
        animateMoveDrawPileTopToBattleField()
        resetDrawAndHealImages()
        // Show the cards that are moved into the battle field positions
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.setBattleFieldCardImagesToBack()            
            self.moveDrawPileTopsBackToOriginalPostions()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setCardImagesWhenCardArrayIsPopulated(self.game.battleFieldFirstPlayer, self.battleFieldFirstPlayer, "First")
            self.setCardImagesWhenCardArrayIsPopulated(self.game.battleFieldSecondPlayer, self.battleFieldSecondPlayer, "First")
        }
    }
    
    // Determine battle winner
    @IBAction func battle(_ sender: Any) {
        game.determineBattleWinner()
        animateMoveBattleCardsToWinningHealPile()
        // Update the images for the heal piles
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.game.roundWinner == "Player 1" {
                self.setCardImagesWhenCardArrayIsPopulated(self.game.healPileFirstPlayer, self.healPileFirstPlayer, "Last")
                self.resetBattleFieldImagesAfterFirstPlayerVictory()
            }
            if self.game.roundWinner == "Player 2" {
                self.setCardImagesWhenCardArrayIsPopulated(self.game.healPileSecondPlayer, self.healPileSecondPlayer, "Last")
                self.resetBattleFieldImagesAfterSecondPlayerVictory()
            }
        }
        // Update the score in the view after the battle
        self.updateScore()
    }
    
    // TODO: show alert when the game is over
    // TODO: prevent interaction with the view when the game has been decided
}
