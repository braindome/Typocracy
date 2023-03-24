//
//  Game.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import Foundation

class Game {
    static let shared = Game(score: 0, listLength: nil, playerName: nil)
    var score = 0
    var listLength : Int?
    var playerName : String?
    var wordList = WordList()
    
    
    private init(score: Int, listLength: Int?, playerName: String?) {
        self.score = score
        self.listLength = listLength
        self.playerName = playerName
    }
    
}
