//
//  PokerGame.swift
//  CardGameApp
//
//  Created by kimdo2297 on 2020/02/15.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

class PokerGame {
    
    private let deck = Deck()
    private let dealer = Player()
    private var players: [Player]!
    private enum GameStut: Int {
        case five = 5, seven = 7
        func isValid(num : Int) -> Bool {
            return self.rawValue == num
        }
    }
    private var gameStut: GameStut!
    
    init?(gameStutNumber: Int , playersNumber: Int) throws {
        guard GameStut.five.isValid(num: gameStutNumber) ||
            GameStut.seven.isValid(num: gameStutNumber) else {
                throw PokerGameError.invalidGameStutNumber
        }
        
        let minPlayersNumber = 1
        let maxPlayersNumber = 4
        guard playersNumber >= minPlayersNumber,
            playersNumber <= maxPlayersNumber else {
                throw PokerGameError.invalidPlayersNumber
        }
        
        self.gameStut = GameStut(rawValue: gameStutNumber)
        players = initPlayers(num: playersNumber)
    }
    
    private func initPlayers(num: Int) -> [Player] {
        var players = [Player]()
        for _ in 0 ..< num {
            players.append(Player())
        }
        return players
    }
}

enum PokerGameError: Error {
    case invalidGameStutNumber
    case invalidPlayersNumber
}
