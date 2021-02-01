//
//  GameLogic.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

class WarGameLogic {
    
    var deck:DeckOfCards?
    public var firstPlayerScore:Int
    public var secondPlayerScore:Int
    // Each player's deck consists of a draw pile and a heal pile
    var firstPlayerDeck = [Card]()
    var secondPlayerDeck = [Card]()
    var drawPileFirstPlayer = [Card]()
    var drawPileSecondPlayer = [Card]()
    var healPileFirstPlayer = [Card]()
    var healPileSecondPlayer = [Card]()
    var battleFieldFirstPlayer = [Card]()
    var battleFieldSecondPlayer = [Card]()
    private var atWar:Bool {
        if (battleFieldFirstPlayer.last!.value == battleFieldSecondPlayer.last!.value && battleFieldIsEmpty == false) {
            return true
        }
        else {
            return false
        }
    }
    private var battleFieldIsEmpty:Bool {
        if battleFieldFirstPlayer.count == 0 && battleFieldSecondPlayer.count == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    init() {
        
        self.deck = DeckOfCards()
        // Player score = number of cards in player deck
        self.firstPlayerScore = firstPlayerDeck.count
        self.secondPlayerScore = secondPlayerDeck.count
        self.drawPileFirstPlayer = firstPlayerDeck
        self.drawPileSecondPlayer = secondPlayerDeck
        self.firstPlayerDeck = drawPileFirstPlayer + healPileFirstPlayer
        self.secondPlayerDeck = drawPileSecondPlayer + healPileSecondPlayer
        self.deal()
        self.checkDrawIsEmpty()
    }
    
    // Deal the deck to two players, one at a time
    private func deal() {

        for (index, card) in deck!.deck.enumerated() {
            
            // 0-indexed, so 0- and even-indexed cards go to firstPlayer, odd-indexed cards go to secondPlayer
            index % 2 == 0 ? firstPlayerDeck.append(card) : secondPlayerDeck.append(card)
        }
        
        // Empty the deck once it has been dealt
        deck!.deck.removeAll()
        
        // Test: Check that player decks are populated with the correct cards
        let bothPlayerDecks = [firstPlayerDeck, secondPlayerDeck]
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
        
        let bothBattlePositions = [battleFieldFirstPlayer, battleFieldSecondPlayer]
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
        moveCardFromOneArrayToAnother(from: &drawPileFirstPlayer, to: &battleFieldFirstPlayer)
        moveCardFromOneArrayToAnother(from: &drawPileSecondPlayer, to: &battleFieldSecondPlayer)
         
        flipCard()
        
        // Every time we move a card onto the battle field, check if the draw piles are empty afterward
        checkDrawIsEmpty()
        
        // TODO: what if you only have one card left?...then your drawpile is empty and so is your heal pile...can we append nothing to an array and it just doesn't break?
    }
    
    
    // Determines where the cards end up during a battle (who wins)
    private func determineBattleWinner() {
        
        // Cards moved into the heal piles will be turned face up no matter what
        func flipWhenMovedToHealPile() {
            
            battleFieldFirstPlayer.forEach {
                
                $0.faceUp = true
            }
            
            battleFieldSecondPlayer.forEach {
                
                $0.faceUp = true
            }
        }
        
        if battleFieldFirstPlayer.last!.value > battleFieldSecondPlayer.last!.value {
        
            flipWhenMovedToHealPile()
            
            // Add cards to player 1's heal pile
            healPileFirstPlayer.append(contentsOf: battleFieldFirstPlayer)
            healPileFirstPlayer.append(contentsOf: battleFieldSecondPlayer)
            
            battleFieldFirstPlayer.removeAll()
            battleFieldSecondPlayer.removeAll()
            
        }
        else if battleFieldFirstPlayer.last!.value < battleFieldSecondPlayer.last!.value {
            
            flipWhenMovedToHealPile()
            
            // Add cards to player 2's heal pile
            healPileSecondPlayer.append(contentsOf: battleFieldFirstPlayer)
            healPileSecondPlayer.append(contentsOf: battleFieldSecondPlayer)
            
            battleFieldFirstPlayer.removeAll()
            battleFieldSecondPlayer.removeAll()
        }
    }

    // Battle - control movement of cards, handle War condition
    func battle() {
        
        repeat {
            
            // Before each round check for a game winner
            checkGameOver()
            
            // Check to see if we are at war
            if atWar {
                
                // Move two cards to the Battle Field
                moveCardToBattleField()
                moveCardToBattleField()
                // Determine a winner or if we are still at War
                determineBattleWinner()
            }
            
            // If the Battle Field is empty, it is a normal battle
            else if battleFieldIsEmpty == true {
                
                moveCardToBattleField()
                determineBattleWinner()
            }
        } while atWar
        // If we are still at War, the while condition is still true, so the code is repeated

    }
    // When a draw pile is empty, the heal pile is shuffled and then transferred to the draw pile
    private func checkDrawIsEmpty() {

        if drawPileFirstPlayer.count == 0 {
            
            drawPileFirstPlayer.append(contentsOf: healPileFirstPlayer.shuffled())
            healPileFirstPlayer.removeAll()
        }
        else {
            return
        }
        
        if drawPileSecondPlayer.count == 0 {
            
            drawPileSecondPlayer.append(contentsOf: healPileSecondPlayer.shuffled())
            healPileSecondPlayer.removeAll()
        }
        else {
            return
        }
    }
    
    private func checkGameOver() {
        
        if firstPlayerDeck.count == 0 {
            
            print("PLAYER 2 WINS!!!!!")
        }
        
        if secondPlayerDeck.count == 0 {
            
            print("PLAYER 2 WINS!!!!!")
        }
    }
}
