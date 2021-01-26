//
//  CardModel.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// Set possible card values with equivalent rawValues
enum CardValue: Int, CaseIterable {
    
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
}

// Set possible suit values
enum Suit : CaseIterable {
    
    case club, diamond, heart, spade
    
}

// Create a model for a given card in a standard 52-card deck
class Card : Deck {
     
    var backImage = "back"
    var suit:Suit
    var value:CardValue.RawValue
    var frontImage:String {
        return "\(suit)"+"\(value)"
    }
    
    // face up or down
    // flip to innvert state
    
    init (suit: Suit, value: CardValue.RawValue) {
        
        self.value = value
        self.suit = suit
        
    }
    
}

