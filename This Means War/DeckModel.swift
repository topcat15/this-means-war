//
//  DeckModel.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// Create a standard 52-card deck from the Card object

class Deck {
    
    // Store the deck
    private var deckArray = [Card]()

    // Create a deck of cards
    private func createCards() {
        
        // Create a set of all possible card values for each possible suit
        for suit in Suit.allCases {
            
            // Create a set of all possible card values
            for value in CardValue.allCases {
                
                let card = Card(suit: suit, value: value.rawValue)
                card.value = value.rawValue
                card.suit = suit
                deckArray.append(card)                
            }
        }
    }
        
    // Shuffle the deck
    private func shuffle() {
        
        deckArray = deckArray.shuffled()
    }
    
    // Test: Check the array
    func viewDeck() {

        deckArray.forEach() {
            print($0.suit, $0.value)
        }
    }
    
    // TODO: 
    var player1Deck = [Card]()
    var player2Deck = [Card]()
    
    // Deal the deck to two players, one at a time
    private func deal() {
        
        for (index, card) in deckArray.enumerated() {
            
            // 0-indexed, so 0- and even-indexed cards go to player1, odd-indexed cards go to player2
            index % 2 == 0 ? player1Deck.append(card) : player2Deck.append(card)
        }
        
        // Empty the deck once it has been dealt
        deckArray.removeAll()
        
        // Test: Check that player decks are populated with the correct cards
        for (index, card) in player1Deck.enumerated() {
            print(index, card.suit, card.value)
        }
        
        for (index, card) in player2Deck.enumerated() {
            print(index, card.suit, card.value)
        }
    }
    
    init() {
        
        createCards()
        shuffle()
        deal()
    }
}
