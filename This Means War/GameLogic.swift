//
//  GameLogic.swift
//  This Means War
//
//  Created by Daniel J Brown on 1/26/21.
//

import Foundation

// Game Start

// Initial player scores
var player1Score = 0
var player2Score = 0

// Initial deal of 52 cards, shuffled

class GameLogic {
    
    public var player1Score = 0
    public var player2Score = 0
    private var deck: Deck?
    private var player1Deck = [Card]()
    private var player2Deck = [Card]()
    private var atWar = false
    
    init(){
        
        self.deck = Deck()
        self.deck?.shuffle()
        self.deck?.viewDeck()
        
        // loop that iterates 26 times
        
        
        // each iteration add a card to each of the player decks
     
        
        
    }
    
//    func deal() -> [Card]? {
//
//        if atWar {
//            // deal three cards face up, one down
//
//            // determine who wins
//
//            // calc score update player1Score, player2Score before return
//
//        }
//        else {
//
//            // pull a card off of player 1's deck, add it to the return array....repeat for player 2
//
//            // if player1deck.count is > 0 && player2deck.count is > 0, now we know there is enough ......if NOT, then we cannot perform the deal function and we returnn nil (GAME OVER)
//
//                // if the cards match then we are in the war state
//
//                    // else normal round, score the round
//                    // score player1 score player2
//
//
//                // return cards
//
//
//            // else return nil
//
//        }
//
//
//
//    }
    
}



// Split deck into two




    // The top card from each player's deck is automatically moved into the Battle Position, with the back of the card being visible


    // The back of the card is hiidden from view thereafter


// Draw Pile

    // No cards appear in discard pile when it is empty

    // OPTIONAL: show outline on board where discard pile goes

// Discard Pile

    // No cards appear in discard pile when it is empty

    // OPTIONAL: show outline on board where discard pile goes


// Determine who wins round

// TODO: When a player wins, they inherit the card from that battle, which is placed in their discard pile

// TODO: When a player's draw pile is empty, shuffle their discard pile and make it their deck

// TODO: Tie condition - players draw cards until one of them wins, and winner claims all cards

// TODO: Win condition - a player wins when the other player has no more cards to draw
