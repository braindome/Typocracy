//
//  Game.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import Foundation

class Game {
    static let shared = Game(score: 0)
    var score = 0
    var wordList = WordList()
    
    
    private init(score: Int) {
        self.score = score

    }
    

}
