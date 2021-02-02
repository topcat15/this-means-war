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
        game.deal()
 //       updateScore()
        self.scoreLabelFirstPlayer.text = String(game.firstPlayerScore)
        self.scoreLabelSecondPlayer.text = String(game.firstPlayerScore)

    }
    
    // Update score
//    func updateScore() {
//
//        self.scoreLabelFirstPlayer.text = String(game.firstPlayerScore)
//        self.scoreLabelSecondPlayer.text = String(game.firstPlayerScore)
//    }
    
//    @IBAction func moveTopOfDrawToBattleField(_ sender: Any) {
//        
//        game.battle()
//        print("player score is: \(game.firstPlayerScore)")
//        
//    }
    
    

    
    
    
    // Draw Pile

        // No cards appear in discard pile when it is empty...another way to say that: only show images of cards if they are in play
    

        // TODO: Show outline on board where discard pile goes

    // Heal Pile

        // No cards appear in discard pile when it is empty

        // OPTIONAL: show outline on board where discard pile goes
    
    
}
