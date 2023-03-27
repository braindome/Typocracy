//
//  Game.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import Foundation

class Game {
    
    var score = 0
    var listLength : Int?
    var playerName : String?
    var wordList = WordList()
    
    
    init(score: Int, listLength: Int?, playerName: String?) {
        self.score = score
        self.listLength = listLength
        self.playerName = playerName
    }
    
}
