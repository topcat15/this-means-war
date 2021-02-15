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
enum Suit : String, CaseIterable {
    
    case club, diamond, heart, spade
}

// A standard playing card
class Card {
    
    var suit: Suit.RawValue
    var value: CardValue.RawValue
    var faceUp = false
    var imageName:String {
        if faceUp {
            // Front Image
            return "\(suit)"+"\(value)"
        }
        else {
            return "back"
        }
    }
    
    init (suit: Suit.RawValue, value: CardValue.RawValue) {

        self.value = value
        self.suit = suit
    }
}

