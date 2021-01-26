//
//  DeckModel.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// Create a standard 52-card deck from the Card object

protocol CardProtocols {

    func createCards() -> [Card]
    func shuffle()
    
}

class Deck {
    
    // Store the deck
    private var deckArray = [Card]()

    // Create a new Card object for the 13 possible cards for the 4 suits
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
    func shuffle() {
        
        deckArray = deckArray.shuffled()
        
    }
    
    // Check that frontImage is being set properly, and that deck is being shuffled
    func viewDeck() {

        deckArray.forEach() {
            print($0.frontImage)
        }

    }
    
    func deal() -> Card? {
        
        if deckArray.count > 0 {
            
            let card = deckArray.first
            deckArray.remove(at: 0)
            return card
            
        }
        
        return nil
    }

    init() {
        
        createCards()
        
    }

}
