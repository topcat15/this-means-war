//
//  GameLogic.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

class GameLogic {
    
    private var deck:Deck?
    public var player1Score:Int
    public var player2Score:Int
    private var atWar = false
    // Each player's deck consists of a draw pile and a heal pile
    var player1Deck = [Card]()
    var player2Deck = [Card]()
    var drawPilePlayer1 = [Card]()
    var drawPilePlayer2 = [Card]()
    var healPilePlayer1 = [Card]()
    var healPilePlayer2 = [Card]()
    var drawIsEmptyPlayer1 = false
    var drawIsEmptyPlayer2 = false
    
    init() {
        
        self.deck = Deck()
        // Player score = number of cards in player deck
        self.player1Score = deck!.player1Deck.count
        self.player2Score = deck!.player2Deck.count
        self.drawPilePlayer1 = deck!.player1Deck
        self.drawPilePlayer2 = deck!.player2Deck
        self.player1Deck = drawPilePlayer1 + healPilePlayer1
        self.player2Deck = drawPilePlayer2 + healPilePlayer2
        self.checkDrawIsEmpty()
        
    }
    
    // The Battle Field
    var battlePosition1 = [Card]()
    var battlePosition2 = [Card]()
    
    // Place the top card from players' decks into the corresponding battle positions
    func moveToBattleField() {
        
        battlePosition1.append(drawPilePlayer1.first!)
        battlePosition2.append(drawPilePlayer2.first!)
         
        for (index, _) in battlePosition1.enumerated() {
        
            // Flip over any card in a 0- or even-indexed position in the battlePosition arrays
            if index % 2 == 0 {
                
                battlePosition1[index].faceUp = true
                battlePosition2[index].faceUp = true
                
            }
            // Do not flip over any card in an odd-indexed position in the battlePosition arrays
            else {
                battlePosition1[index].faceUp = false
                battlePosition2[index].faceUp = false
            }
        }
        
        // Remove the cards from the draw pile arrays
        drawPilePlayer1.removeFirst()
        drawPilePlayer2.removeFirst()
        
        // Every time we move a card onto the battle field, check if the draw piles are empty afterward
        checkDrawIsEmpty()

    }
    
    // Battle - determine who wins
    func battle() {
        
        repeat {
            
            // First, check to see if we are at war
            if battlePosition1.count > 1 {
                
                moveToBattleField()
                moveToBattleField()
                
            }
            
            // Second, check to make sure Battle Field is not empty (otherwise you cannot battle)
            else if battlePosition1.count > 0 && battlePosition2.count > 0 {
                
                moveToBattleField()
                
                if battlePosition1.last!.value > battlePosition2.last!.value {
                
                    // Add cards to player 1's heal pile
                    healPilePlayer1.append(contentsOf: battlePosition1)
                    healPilePlayer1.append(contentsOf: battlePosition2)
                    
                    battlePosition1.removeAll()
                    battlePosition1.removeAll()
                
                }
                else if battlePosition1.last!.value < battlePosition2.last!.value {
                    
                    // Add cards to player 2's heal pile
                    healPilePlayer2.append(contentsOf: battlePosition1)
                    healPilePlayer2.append(contentsOf: battlePosition2)
                    
                    battlePosition1.removeAll()
                    battlePosition1.removeAll()
                    
                }
                
            }
            
        } while battlePosition1.last!.value == battlePosition2.last!.value
    }

    // When a draw pile is empty, the heal pile is shuffled and then transferred to the draw pile
    func checkDrawIsEmpty() {
        
        let drawCountPlayer1 = drawPilePlayer1.count
        let drawCountPlayer2 = drawPilePlayer2.count
        
        // For player 1
        switch drawCountPlayer1 {
        
        case 0:
            
            drawIsEmpty = true
            drawPilePlayer1.append(contentsOf: healPilePlayer1.shuffled())
            healPilePlayer1.removeAll()
        
        default:
            
            drawIsEmpty = false
        
        }
        
        // For player 2
        switch drawCountPlayer2 {
        
        case 0:
            
            drawIsEmpty = true
            drawPilePlayer2.append(contentsOf: healPilePlayer2.shuffled())
            healPilePlayer2.removeAll()
        
        default:
            
            drawIsEmpty = false
        
        }
        
    }
    
    func checkWinner {
        
        if player1deck.count = 0 {
            print("PLAYER 2 WINS!!!!!")
        }
        else {
            print("PLAYER 1 WINS!!!!!")
        }
    }
                
    
    
//    func deal() -> [Card]? {
//
//        if atWar {
//            // deal three cards face up, one down
//
//            // determine who wins
//
//
//        }
//        else {
//
//            // pull a card off of player 1's deck, add it to the return array....repeat for player 2
//
//            // if player1deck.count is > 0 && player2deck.count is > 0, now we know there is enough ......if NOT, then we cannot perform the deal function and we returnn nil (GAME OVER)
//
//                // if the cards match then we are in the war state
//
//                    // else normal round, score the round
//                    // score player1 score player2
//
//
//                // return cards
//
//
//            // else return nil
//
//        }
//
//
//
//    }
    
}


// Draw Pile

    // No cards appear in discard pile when it is empty

    // OPTIONAL: show outline on board where discard pile goes

// Heal Pile

    // No cards appear in discard pile when it is empty

    // OPTIONAL: show outline on board where discard pile goes


// TODO: When a player's draw pile is empty, shuffle their discard pile and make it their deck

// TODO: Win condition - a player wins when the other player has no more cards to draw
