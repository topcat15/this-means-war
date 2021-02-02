//
//  DeckModel.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// A standard 52-card deck, shuffled
class DeckOfCards {
    
    // THIS IS A TEST
    
    // Store the deck
    var deck = [Card]()

    // Create a deck of cards
    private func addCardsToDeck() {
        
        // Create the cards for each of the 4 suits
        for suit in Suit.allCases {

            // Create a set of cards (2...A)
            for value in CardValue.allCases {

                let card = Card(suit: suit, value: value.rawValue)
                card.value = value.rawValue
                card.suit = suit
                deck.append(card)
                
                // Logging to verify card creation
                print("created card " + "\(suit) \(value)" )
            }
        }
        
        

    }
    
    private func shuffle() {
        
        deck = deck.shuffled()
    }
    
    // Test: Check the array
    func viewDeck() {

        deck.forEach() {
            print($0.suit, $0.value)
        }
    }
    
    init() {
        
        addCardsToDeck()
        shuffle()
    }
}
