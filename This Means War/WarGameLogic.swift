//
//  GameLogic.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

class WarGameLogic {
    
    var deck:DeckOfCards?
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
    var battleFieldPlayer1 = [Card]()
    var battleFieldPlayer2 = [Card]()
    
    init() {
        
        self.deck = DeckOfCards()
        // Player score = number of cards in player deck
        self.player1Score = player1Deck.count
        self.player2Score = player2Deck.count
        self.drawPilePlayer1 = player1Deck
        self.drawPilePlayer2 = player2Deck
        self.player1Deck = drawPilePlayer1 + healPilePlayer1
        self.player2Deck = drawPilePlayer2 + healPilePlayer2
        self.deal()
        self.checkDrawIsEmpty()
    }
    
    // Deal the deck to two players, one at a time
    private func deal() {

        for (index, card) in deck!.deck.enumerated() {
            
            // 0-indexed, so 0- and even-indexed cards go to player1, odd-indexed cards go to player2
            index % 2 == 0 ? player1Deck.append(card) : player2Deck.append(card)
        }
        
        // Empty the deck once it has been dealt
        deck!.deck.removeAll()
        
        // Test: Check that player decks are populated with the correct cards
        let bothPlayerDecks = [player1Deck, player2Deck]
        for (_, playerDeck) in bothPlayerDecks.enumerated() {

            for (index, card) in playerDeck.enumerated() {
                print(index, card.suit, card.value)
            }
        }
    }
    
    private func moveCardFromOneArrayToAnother(from: inout [Card], to: inout [Card]) {
        
        guard let card = from.first else {
            return
        }
        
        to.append(card)
        from.removeFirst()
    }
    
    // Flip cards in Battle Field depending on whether or not players are in state of War
    func flipCard() {
        
        let bothBattlePositions = [battleFieldPlayer1, battleFieldPlayer2]
        // The outer for loop makes sure the same action is taken or both players
        // TODO: find solution so I don't have to force unwrap bothBattlePositions
        for position in bothBattlePositions {
        
            for (index, _) in position.enumerated() {
            
                // Flip over any card in a 0- or even-indexed position in the battlePosition arrays
                if index % 2 == 0 {
                    
                    position[index].faceUp = true
                }
                // Do not flip over any card in an odd-indexed position in the battlePosition arrays
                else {
                    position[index].faceUp = false
                }
            }
        }
    }
    
    private func moveCardToBattleField() {
        
        // First, check to see if there is a winner
        // TODO: check if game over is bool value
        checkGameOver()
        
        // Place the top card from players' decks into the corresponding battle positions
        moveCardFromOneArrayToAnother(from: &drawPilePlayer1, to: &battleFieldPlayer1)
        moveCardFromOneArrayToAnother(from: &drawPilePlayer2, to: &battleFieldPlayer2)
         
        flipCard()
        
        // Every time we move a card onto the battle field, check if the draw piles are empty afterward
        checkDrawIsEmpty()
        
        // TODO: what if you only have one card left?...then your drawpile is empty and so is your heal pile...can we append nothing to an array and it just doesn't break?
    }
    
    // Determines where the cards end up during a battle (who wins)
    private func moveToHealPile() {
        
        // Cards moved into the heal piles will be turned face up no matter what
        func flipWhenMovedToHealPile() {
            
            battleFieldPlayer1.forEach {
                
                $0.faceUp = true
            }
            
            battleFieldPlayer2.forEach {
                
                $0.faceUp = true
            }
        }
        
        if battleFieldPlayer1.last!.value > battleFieldPlayer2.last!.value {
        
            flipWhenMovedToHealPile()
            
            // Add cards to player 1's heal pile
            healPilePlayer1.append(contentsOf: battleFieldPlayer1)
            healPilePlayer1.append(contentsOf: battleFieldPlayer2)
            
            battleFieldPlayer1.removeAll()
            battleFieldPlayer2.removeAll()
            
        }
        else if battleFieldPlayer1.last!.value < battleFieldPlayer2.last!.value {
            
            flipWhenMovedToHealPile()
            
            // Add cards to player 2's heal pile
            healPilePlayer2.append(contentsOf: battleFieldPlayer1)
            healPilePlayer2.append(contentsOf: battleFieldPlayer2)
            
            battleFieldPlayer1.removeAll()
            battleFieldPlayer2.removeAll()
        }
    }

    // Battle - control movement of cards, handle War condition
    func battle() {
        
        repeat {
            
            // Before each round we should check for a game winner
            checkGameOver()
            
            // First, check to see if we are at war
            if battleFieldPlayer1.count > 1 {
                
                // Move two cards to the Battle Field
                moveCardToBattleField()
                moveCardToBattleField()
                // Determine a winner or if we are still at War
                moveToHealPile()
            }
            
            // Second, check to make sure Battle Field is not empty (otherwise you cannot battle)
            else if battleFieldPlayer1.count > 0 && battleFieldPlayer2.count > 0 {
                
                moveCardToBattleField()
                moveToHealPile()
            }
        } while battleFieldPlayer1.last!.value == battleFieldPlayer2.last!.value
        // If we are still at War, the while condition is still true, so the code is repeated

    }
    // When a draw pile is empty, the heal pile is shuffled and then transferred to the draw pile
    private func checkDrawIsEmpty() {

        if drawPilePlayer1.count == 0 {
            
            drawPilePlayer1.append(contentsOf: healPilePlayer1.shuffled())
            healPilePlayer1.removeAll()
        }
        else {
            return
        }
        
        if drawPilePlayer2.count == 0 {
            
            drawPilePlayer2.append(contentsOf: healPilePlayer2.shuffled())
            healPilePlayer2.removeAll()
        }
        else {
            return
        }
    }
    
    private func checkGameOver() {
        
        if player1Deck.count == 0 {
            
            print("PLAYER 2 WINS!!!!!")
        }
        
        if player2Deck.count == 0 {
            
            print("PLAYER 2 WINS!!!!!")
        }
    }
}
