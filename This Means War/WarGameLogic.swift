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
    var winner = ""
    private var atWar:Bool {
        guard let card1 = battleFieldFirstPlayer.last else {
            return false
        }
        guard let card2 = battleFieldSecondPlayer.last else {
            return false
        }
        return (card1.value == card2.value)
    }
    // TODO: use guard
    private var battleFieldIsEmpty:Bool {
        if battleFieldFirstPlayer.count == 0 && battleFieldSecondPlayer.count == 0 {
            return true
        }
        else {
            return false
        }
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
    
    // Deal the deck to two players, one at a time
    func deal() {
        
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
    
    private func moveCardFromOneArrayToAnother(from: inout [Card], to: inout [Card]) {
        
        guard let card = from.first else {
            return
        }
        
        to.append(card)
        from.removeFirst()

    }
    
    private func moveAllCardsFromOneArrayToAnother(from: inout [Card], to: inout [Card]) {
        
        guard from.first != nil else {
            return
        }
        
        to.append(contentsOf: from)
        from.removeAll()
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
    
    func moveCardToBattleField() {
        
        // First, check to see if there is a winner
        // TODO: check if game over is bool value
        checkGameOver()
        
        // Place the top card from players' decks into the corresponding battle positions
        moveCardFromOneArrayToAnother(from: &drawPileFirstPlayer, to: &battleFieldFirstPlayer)
        moveCardFromOneArrayToAnother(from: &drawPileSecondPlayer, to: &battleFieldSecondPlayer)

        flipCard()
        
        // Every time we move a card onto the battle field, check if the draw piles are empty afterward
        keepDrawPilesFull()
        
        print(battleFieldFirstPlayer[0].faceUp, battleFieldFirstPlayer[0].image)
        
        // TODO: what if you only have one card left?...then your drawpile is empty and so is your heal pile...can we append nothing to an array and it just doesn't break?
    }
    
    // Determines where the cards end up during a battle (who wins)
    func determineBattleWinner() {
        
        // Cards moved into the heal piles will be turned face up no matter what
        func flipWhenMovedToHealPile() {
            
            battleFieldFirstPlayer.forEach {
                
                $0.faceUp = true
            }
            
            battleFieldSecondPlayer.forEach {
                
                $0.faceUp = true
            }
        }
        if battleFieldFirstPlayer.last != nil {
            
            if battleFieldFirstPlayer.last!.value > battleFieldSecondPlayer.last!.value {
            
                flipWhenMovedToHealPile()
                
                // Add cards to player 1's heal pile, with the winning card added second (it will appear on top)
                moveAllCardsFromOneArrayToAnother(from: &battleFieldSecondPlayer, to: &healPileFirstPlayer)
                moveAllCardsFromOneArrayToAnother(from: &battleFieldFirstPlayer, to: &healPileFirstPlayer)
                
                winner = "Player 1"
                
                print("\(winner) wins")
            }
            else if battleFieldFirstPlayer.last!.value < battleFieldSecondPlayer.last!.value {
                
                flipWhenMovedToHealPile()
                
                // Add cards to player 2's heal pile, with the winning card added second (it will appear on top)
                moveAllCardsFromOneArrayToAnother(from: &battleFieldFirstPlayer, to: &healPileSecondPlayer)
                moveAllCardsFromOneArrayToAnother(from: &battleFieldSecondPlayer, to: &healPileSecondPlayer)
                
                winner = "Player 2"
                
                print("\(winner) wins")
            }
            else {
                // TODO: make it so the other cards that are part of the war appear
                moveCardToBattleField()
                determineBattleWinner()
            }
        }
    }

    // Battle - control movement of cards, handle War condition
    func battle() {
        
        repeat {

            // Before each round check for a game winner
            checkGameOver()

            // Check to see if we are at war
            if atWar == true {

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
        } while atWar == true
        // If we are still at War, the while condition is still true, so the code is repeated

    }
    // When a draw pile is empty, the heal pile is shuffled and then transferred to the draw pile
    func checkIfArrayOfCardsIsEmpty(_ arrayOfCards: [Card]) -> Bool {

        guard arrayOfCards.first != nil else {
            return true
        }
        return false
    }
        
    // If a player's draw pile is empty, shuffle their heal pile and move it to their draw pile
    func moveShuffledHealPileToDrawPile(_ healPile: inout [Card], _ drawPile: inout [Card]) {
        
        if checkIfArrayOfCardsIsEmpty(drawPile) == true {
            
            var shuffledHealPile = healPile.shuffled()
            
            moveAllCardsFromOneArrayToAnother(from: &shuffledHealPile, to: &drawPile)
            healPile.removeAll()
        }
    }
    
    // Check draw piles after moving a card, make sure they are not empty
    func keepDrawPilesFull() {
        
        moveShuffledHealPileToDrawPile(&drawPileFirstPlayer, &healPileFirstPlayer)
        moveShuffledHealPileToDrawPile(&drawPileSecondPlayer, &healPileSecondPlayer)
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
