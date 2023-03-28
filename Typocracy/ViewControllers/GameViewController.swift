//
//  GameViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-21.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var countdownTimer : Timer?
    var countdownTime = 8
    var gameLength : Int?
    var playerName : String?
    var currentList : [String?] = []
    var currentGame : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        currentGame = Game(score: 0, listLength: gameLength, playerName: playerName)
    
        inputField.delegate = self
        scoreLabel.text = "Score: \(currentGame!.score)"
        countdownLabel.text = "\(countdownTime)"
        
        inputField.text = ""
        
        //print("Game length: \(String(describing: gameLength))")
        //print("Player name: \(String(describing: playerName))")

        currentList = currentGame!.wordList.getList(stringList: currentGame!.wordList.stringList, n: gameLength!)
        wordLabel.text = generateNewWord()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFinalScore" {
            if let finalScoreVC = segue.destination as? FinalScoreViewController {
                finalScoreVC.name = playerName
                if let scoreText = scoreLabel.text, let score = Int(scoreText) {
                    finalScoreVC.score = score
                }
            }
        }
    }
    
    func textField(_ textField : UITextField, shouldChangeCharactersIn range : NSRange, replacementString string : String) -> Bool {
    
        // Nil check (acts as if...)
        guard let inputText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if inputText.contains(wordLabel.text!) {
            currentGame!.score += 1
            wordLabel.text = generateNewWord()
            textField.text = ""

        } else if countdownTime == 0 {
            currentGame!.score -= 1
            wordLabel.text = generateNewWord()
            textField.text = ""

        }
        
        scoreLabel.text = String(currentGame!.score)

        return true
    }
    
    
    // Flytta till modellen?
    func generateNewWord() -> String {
        
        countdownTime = 8
        countdownLabel.text = "\(countdownTime)"
        
        if currentList.isEmpty {
            endGame()
            return ""
        }
        
        let currentWord = wordLabel.text ?? ""
        currentList.removeAll { $0 == currentWord }
        
        guard let randomWord = currentList.randomElement() else {
            endGame()
            return ""
        }
        
        currentList = currentList.filter { $0 != wordLabel.text }

        countdownTimer?.invalidate()
        startCountdown()
        countdownTimer?.fire()
        
        
        return randomWord!
    }
    
    
    // Creates a timer that repeats indefinitely with interval 1 sec. Third parameter is a closure.
    // The closure captures a reference to self using [weak self]. This is necessary to avoid a retain cycle.
    // The closure decrements countdownTime by 1, and updates the countdownLabel to show the new value of countdownTime.
    func startCountdown() {

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdownTime -= 1
            self.countdownLabel.text = "\(self.countdownTime)"
            if self.countdownTime == 0 {
                timer.invalidate()
                
                self.currentGame!.score -= 1
                self.scoreLabel.text = String(self.currentGame!.score)
                self.wordLabel.text = self.generateNewWord()
                self.inputField.text = ""
            }
        }
    }
    
    
    // Flytta till modellen?
    func endGame() {
        
        // Show alert with final score
        let alert = UIAlertController(title: "Game Over", message: "Your final score is \(currentGame!.score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "segueToFinalScore", sender: nil)

        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
