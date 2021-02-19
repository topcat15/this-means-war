//
//  DeckModel.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// A standard 52-card deck
class DeckOfCards {
    var deck = [Card]()
    
    init() {
        addCardsToDeck()
    }
    
    private func addCardsToDeck() {
        for suit in Suit.allCases {
            for value in CardValue.allCases {
                let card = Card(suit: suit.rawValue, value: value.rawValue)
                card.value = value.rawValue
                card.suit = suit.rawValue
                deck.append(card)
            }
        }
    }
    
    // TEST: Check the array
    func viewDeck() {
        deck.forEach({print($0.suit, $0.value)})
    }
}
