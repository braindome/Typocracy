//
//  Game.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import Foundation
import UIKit

class Game {
    
    var score = 0
    var listLength : Int?
    var playerName : String?
    var currentList : [String?] = []
    var currentWord : String?
    var countdownTime = 8
    var countdownTimer : Timer?
    var wordList = WordList()
    var countdownUpdateHandler: ((Int) -> Void)?
    

    
    init(score: Int, listLength: Int?, playerName: String?) {
        self.score = score
        self.listLength = listLength
        self.playerName = playerName
        currentList = wordList.getList(stringList: wordList.stringList, n: listLength!)

    }
    
    func generateNewWord() -> String {

        countdownTime = 8
        
        if currentList.isEmpty {
            return ""
        }
                
        guard let randomWord = currentList.randomElement() else {
            return ""
        }
        
        currentList.removeAll { $0 == randomWord }
        
        countdownTimer?.invalidate()
        startCountdown()
        countdownTimer?.fire()
        
        return randomWord!
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdownTime -= 1
            self.countdownUpdateHandler?(self.countdownTime)
            if self.countdownTime == 0 {
                timer.invalidate()
                
                self.score -= 1
                self.currentWord = self.generateNewWord()
            }
        }
    }
    
}
