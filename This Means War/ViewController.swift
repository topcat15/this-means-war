//
//  ViewController.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftCardView: UIImageView!
    
    @IBOutlet weak var rightCardView: UIImageView!
    
    @IBOutlet weak var player1Deck: UIImageView!
    
    @IBOutlet weak var player2Deck: UIImageView!
    
    @IBOutlet weak var player1ScoreLabel: UILabel!
    
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set card images to default value
        
        let cards = [player1Deck, player2Deck, leftCardView, rightCardView]

        for i in cards {

            i?.image = UIImage(named: "back")

        }
            
        _ = Deck()
    }
    


//    @IBAction func dealTapped(_ sender: Any) {
//
//        // Randomize some numbers
//        let leftCard = Int.random(in: 2...14)
//        let rightCard = Int.random(in: 2...14)
//
//        // Update the image views
//        leftCardView.image = UIImage(named: "card\(leftCard)")
//        rightCardView.image = UIImage(named: "card\(rightCard)")
//
//        // compare the random numbers to determine who wins, update score variables
//        player1Score += (leftCard > rightCard ? 1 : 0)
//        player2Score += (rightCard > leftCard ? 1 : 0)
//
//        // Update the score labels
//        player1ScoreLabel.text = String(player1Score)
//        player2ScoreLabel.text = String(player2Score)
//
//    }
    
    // Reset image views and score labels
//    @IBAction func resetTapped(_ sender: Any) {
//
//        leftCardView.image = UIImage(named: "back")
//        rightCardView.image = UIImage(named: "back")
//
//        player1Score = 0
//        player2Score = 0
//
//        player1ScoreLabel.text = String(player1Score)
//        player2ScoreLabel.text = String(player2Score)
//
//    }
    
}
