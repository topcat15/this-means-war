//
//  GameLogic.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

class WarGameLogic {
    
    var warDeck:DeckOfCards?
    
    // Each player's deck consists of a draw pile and a heal pile
    var drawPileFirstPlayer = [Card]()
    var drawPileSecondPlayer = [Card]()
    var healPileFirstPlayer = [Card]()
    var healPileSecondPlayer = [Card]()
    var battleFieldFirstPlayer = [Card]()
    var battleFieldSecondPlayer = [Card]()
    
    var roundWinner = ""
    
    private var atWar:Bool {
        
        guard let card1 = battleFieldFirstPlayer.last else {
            return false
        }
        guard let card2 = battleFieldSecondPlayer.last else {
            return false
        }
        return (card1.value == card2.value)
    }
    
    private var battleFieldIsEmpty:Bool {
        
        guard battleFieldFirstPlayer.count == 0 && battleFieldSecondPlayer.count == 0 else {
            return false
        }
        
        return true
    }
    
    // Player 1 score
    var firstPlayerDeck:[Card] {
        get {
            drawPileFirstPlayer + healPileFirstPlayer
        }
    }
    
    // Player 2 score
    var secondPlayerDeck:[Card] {
        get {
            drawPileSecondPlayer + healPileSecondPlayer
        }
    }
    
    init() {
        
        self.warDeck = DeckOfCards()
        self.deal()
        
    }
    
    func checkIfArrayOfCardsIsEmpty(_ arrayOfCards: [Card]) -> Bool {

        guard arrayOfCards.last != nil else {
            return true
        }
        return false
    }
    
    private func checkIfBattleFieldPostionsAreEmpty() -> Bool{
        
        guard checkIfArrayOfCardsIsEmpty(battleFieldFirstPlayer) == false && checkIfArrayOfCardsIsEmpty(battleFieldSecondPlayer) == false else {
            return true
        }
        return false
    }
    
    private func moveCardFromOneArrayToAnother(from: inout [Card], to: inout [Card]) {
        
        guard let card = from.first else {
            return
        }
        
        to.append(card)
        from.removeFirst()
    }
    
    func moveTopCardFromDrawPilesIntoBattleField() {
        
        moveCardFromOneArrayToAnother(from: &drawPileFirstPlayer, to: &battleFieldFirstPlayer)
        moveCardFromOneArrayToAnother(from: &drawPileSecondPlayer, to: &battleFieldSecondPlayer)
        
        // Logging battle cards
        print("Player 1's card is \(battleFieldFirstPlayer[0].value) of \(battleFieldFirstPlayer[0].suit)")
        print("Player 2's card is \(battleFieldSecondPlayer[0].value) of \(battleFieldSecondPlayer[0].suit)")

        flipCards()
    }
    
    func moveCardToBattleFieldIfGameNotOver() {
        
        // First, check to see if there is a winner
        if checkGameOver() == false {
            
            moveTopCardFromDrawPilesIntoBattleField()
            
            // Get the draw pile filled if it is empty after moving a card to the battle field
            keepDrawPilesFull()
        }
    }
    
    private func moveAllCardsFromOneArrayToAnother(from: inout [Card], to: inout [Card]) {
        
        guard from.first != nil else {
            return
        }
        
        to.append(contentsOf: from)
        from.removeAll()
    }
    
    // Add cards to winning player's heal pile, with the winning card added second (it will appear on top)
    func moveAllCardsToHealPile(_ from1: inout [Card], _ from2: inout [Card], _ healPile: inout [Card]) {
        
        moveAllCardsFromOneArrayToAnother(from: &from2, to: &healPile)
        moveAllCardsFromOneArrayToAnother(from: &from1, to: &healPile)
    }
    
    private func moveAllCardsFromBattleFieldToWinningHealPile(_ winner: String) {
        
        if winner == "Player 1" {
            
            roundWinner = "Player 1"
            
            moveAllCardsToHealPile(&battleFieldFirstPlayer, &battleFieldSecondPlayer, &healPileFirstPlayer)
        }
        else {
            
            roundWinner = "Player 2"

            moveAllCardsToHealPile(&battleFieldSecondPlayer, &battleFieldFirstPlayer, &healPileSecondPlayer)
        }
        
        flipWhenMovedToHealPile()
        
        // Logging winner
        print("\(winner) wins")
    }
    
    // Determines where the cards end up during a battle (who wins)
    func determineBattleWinner() {
        
        if checkIfBattleFieldPostionsAreEmpty() == false {
            
            if battleFieldFirstPlayer.last!.value > battleFieldSecondPlayer.last!.value {
                
                moveAllCardsFromBattleFieldToWinningHealPile("Player 1")
                
                // Get the draw pile filled if it is empty after a battle (in case a player has one card left and wins a battle)
                keepDrawPilesFull()
            }
            else if battleFieldFirstPlayer.last!.value < battleFieldSecondPlayer.last!.value {
                
                moveAllCardsFromBattleFieldToWinningHealPile("Player 2")
                
                keepDrawPilesFull()
            }
            else {
                // TODO: make it so the other cards that are part of the war appear
                moveCardToBattleFieldIfGameNotOver()
                determineBattleWinner()
            }
        }
    }
    
    // Flip cards in Battle Field depending on whether or not players are in state of War
    private func flipCards() {
        
        let bothBattlePositions = [battleFieldFirstPlayer, battleFieldSecondPlayer]
        
        // The outer for loop makes sure the same action is taken or both players
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
    
    // Cards moved into the heal piles will be turned face up no matter what
    func flipWhenMovedToHealPile() {
        
        battleFieldFirstPlayer.forEach {
            
            $0.faceUp = true
        }
        
        battleFieldSecondPlayer.forEach {
            
            $0.faceUp = true
        }
    }

    // Check draw piles after moving a card, make sure they are not empty
    private func keepDrawPilesFull() {
        
        // If a player's draw pile is empty, shuffle their heal pile and move it to their draw pile
        func moveShuffledHealPileToDrawPile(_ healPile: inout [Card], _ drawPile: inout [Card]) {
            
            if checkIfArrayOfCardsIsEmpty(drawPile) == true {
                
                var shuffledHealPile = healPile.shuffled()
                
                moveAllCardsFromOneArrayToAnother(from: &shuffledHealPile, to: &drawPile)
                healPile.removeAll()
            }
        }
        
        moveShuffledHealPileToDrawPile(&healPileFirstPlayer, &drawPileFirstPlayer)
        moveShuffledHealPileToDrawPile(&healPileSecondPlayer, &drawPileSecondPlayer)
    }
    
    private func checkGameOver() -> Bool {
        
        guard firstPlayerDeck.count == 0 || secondPlayerDeck.count == 0 else {
            return false
        }
        
        print("GAME OVER!!!")
        
        return true
    }
    
    // Deal the deck to two players, one at a time
    private func deal() {
        
        var beginningFirstPlayerDeck = [Card]()
        var beginningSecondPlayerDeck = [Card]()
        
        for (index, card) in warDeck!.deck.enumerated() {
            
            // 0-indexed, so 0- and even-indexed cards go to firstPlayer, odd-indexed cards go to secondPlayer
            index % 2 == 0 ? beginningFirstPlayerDeck.append(card) : beginningSecondPlayerDeck.append(card)
        }
        
        drawPileFirstPlayer.append(contentsOf: beginningFirstPlayerDeck)
        drawPileSecondPlayer.append(contentsOf: beginningSecondPlayerDeck)
        
        // Test: Check that player decks are populated with the correct cards
        let bothPlayerDecks = [firstPlayerDeck, secondPlayerDeck]
        for (_, playerDeck) in bothPlayerDecks.enumerated() {

            for (index, card) in playerDeck.enumerated() {
                print(index, card.suit, card.value)
            }
        }
    }
    
    // Battle - control movement of cards, handle War condition
    func battle() {
        
        repeat {

            // Before each round check for a game winner
            //checkGameOver()

            // Check to see if we are at war
            if atWar == true {

                // Move two cards to the Battle Field
                moveCardToBattleFieldIfGameNotOver()
                moveCardToBattleFieldIfGameNotOver()
                // Determine a winner or if we are still at War
                determineBattleWinner()
            }

            // If the Battle Field is empty, it is a normal battle
            else if battleFieldIsEmpty == true {

                moveCardToBattleFieldIfGameNotOver()
                determineBattleWinner()
            }
        } while atWar == true
        // If we are still at War, the while condition is still true, so the code is repeated
    }
}
