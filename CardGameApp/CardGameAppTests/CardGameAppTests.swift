//
//  CardGameAppTests.swift
//  CardGameAppTests
//
//  Created by kimdo2297 on 2020/02/06.
//  Copyright © 2020 Jason. All rights reserved.
//

import XCTest
@testable import CardGameApp
class CardGameAppTests: XCTestCase {
    var sut : Deck!
    
    override func setUp() {
        super.setUp()
        sut = Deck()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDeckCount(){
        // 1. given
        sut = Deck()
        // 2. when
        let count = sut.count
        // 3. then
        XCTAssertEqual(count,
                       52,
                       "sut.count is wrong")
    }
    
    func testShuffle(){
        // 1. given
        let other = sut
        // 2. when
        sut.shuffle()

        // 3. then
        XCTAssertNotEqual(other, sut)
    }
    
    func testRemoveOne() {
        // 1.given
        sut = Deck()
        let card = Card(suit: .spade, number: .ace)
    
        // 2.when
        let result = sut.removeOne()
        
        // 3.then
        XCTAssertEqual(card , result)
    }
    
    func testReset() {
        // 1.given
        let other = sut

        // 2.when
        sut.shuffle()
        sut.reset()
        
        // 3.then
        XCTAssertEqual(other, sut)
    }
    
    func testScenario(){
        let totalCardCounts = 52
        var other = sut
        XCTAssertEqual(other?.count, totalCardCounts)
        
        other?.shuffle()
        
        print(other!.removeOne()!.description)
        XCTAssertEqual(other?.count, totalCardCounts - 1 )
        
        print(other!.removeOne()!.description)
        XCTAssertEqual(other?.count, totalCardCounts - 2 )
    }
}
