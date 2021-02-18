//
//  This_Means_WarTests.swift
//  This Means WarTests
//
//  Created by Daniel J Brown on 2/6/21.
//

import XCTest
@testable import This_Means_War

class This_Means_WarTests: XCTestCase {

    var game: WarGameLogic!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        game = WarGameLogic()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        game = nil
    }
    
    // MARK: - Player Deck Tests
     
    // This a
    func testDefaultImageNameForCardsAtGameStart() {

        let expectedArray1 = Array(repeating: false, count: 26)
        let expectedArray2 = Array(repeating: "back", count: 26)

        XCTAssertEqual(game.firstPlayerDeck.map{$0.faceUp}, expectedArray1)
        XCTAssertEqual(game.secondPlayerDeck.map{$0.faceUp}, expectedArray1)
//

        func testGameCompletesWithoutError() throws {

            XCTAssertEqual(game.firstPlayerDeck.map{$0.imageName}, expectedArray2)
            XCTAssertEqual(game.secondPlayerDeck.map{$0.imageName}, expectedArray2)
        }
    }
    
    // TODO: Write tests for number of cards in deck and player decks
    
    // TODO: To test that all the expected values are in the deck, I could check that there are 52 cards and that each card in the deck is unique
    
    // TODO: To test randomization of the dealt deck, I could check that the dealt deck does not equal the initial deck or 2)
    
}
