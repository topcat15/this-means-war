//
//  ViewController.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import UIKit

//protocol DeckProtocols {
//
//    func moveCardToBattleField()
//
//}

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
//    var delegate: DeckProtocols?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawPileFirstPlayer.image = UIImage(named: "back")
        self.drawPileSecondPlayer.image = UIImage(named: "back")
        self.battleFieldFirstPlayer.image = UIImage(named: "outline")
        self.battleFieldSecondPlayer.image = UIImage(named: "outline")
        self.healPileFirstPlayer.image = UIImage(named: "outline")
        self.healPileSecondPlayer.image = UIImage(named: "outline")
 //       updateScore()
        self.scoreLabelFirstPlayer.text = String(game.firstPlayerDeck.count)
        self.scoreLabelSecondPlayer.text = String(game.secondPlayerDeck.count)

    }
    
    func updateScore() {

     scoreLabelFirstPlayer.text = String(game.firstPlayerDeck.count)
     scoreLabelSecondPlayer.text = String(game.secondPlayerDeck.count)
    }
    
    
    @IBAction func moveTopOfDrawToBattleField(_ sender: Any) {
         
        game.moveCardToBattleField()
        
        // Check to see if the
        if game.checkIfArrayOfCardsIsEmpty(game.battleFieldFirstPlayer) == false {
         
            battleFieldFirstPlayer.image = UIImage(named: "\(game.battleFieldFirstPlayer.first!.image)")
        }
        if game.checkIfArrayOfCardsIsEmpty(game.battleFieldSecondPlayer) == false {
            battleFieldSecondPlayer.image = UIImage(named: "\(game.battleFieldSecondPlayer.first!.image)")
        }
    }
    
    @IBAction func battle(_ sender: Any) {
        
        game.determineBattleWinner()
        
        if game.winner == "Player 1" {
            
            healPileFirstPlayer.image = UIImage(named: "\(game.healPileFirstPlayer.last!.image)")
            
        }
        
        if game.winner == "Player 2" {
            
            healPileSecondPlayer.image = UIImage(named: "\(game.healPileSecondPlayer.last!.image)")
            
        }
        
        battleFieldFirstPlayer.image = UIImage(named: "outline")
        battleFieldSecondPlayer.image = UIImage(named: "outline")
        
        // Update the score in the view after the battle
        updateScore()
    }
    
    

    
    
    
    // Draw Pile

        // No cards appear in discard pile when it is empty...another way to say that: only show images of cards if they are in play
    

    // Heal Pile

        // No cards appear in discard pile when it is empty


    
}
