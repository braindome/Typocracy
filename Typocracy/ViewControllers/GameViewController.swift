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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        inputField.delegate = self
        scoreLabel.text = "Score: \(Game.shared.score)"
        countdownLabel.text = "\(countdownTime)"
        
        inputField.text = ""
        //print("Game length: \(String(describing: gameLength))")
        //print("Player name: \(String(describing: playerName))")
        
        //UserDefaults.standard.set(playerName, forKey: "playerName")
        //UserDefaults.standard.set(Game.shared.score, forKey: "finalScore")

        //listRef = Game.shared.wordList
        currentList = Game.shared.wordList.getList(stringList: Game.shared.wordList.stringList, n: gameLength!)
        wordLabel.text = generateNewWord()
    
    }
    
    func textField(_ textField : UITextField, shouldChangeCharactersIn range : NSRange, replacementString string : String) -> Bool {
    
        // Nil check (acts as if...)
        guard let inputText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if inputText == wordLabel.text {
            textField.text = ""
            Game.shared.score += 1
            scoreLabel.text = String(Game.shared.score)
            wordLabel.text = generateNewWord()
            inputField.resignFirstResponder()
            inputField.text = ""
            inputField.becomeFirstResponder()
        } else if countdownTime == 0 {
            textField.text = ""
            Game.shared.score -= 1
            scoreLabel.text = String(Game.shared.score)
            wordLabel.text = generateNewWord()
            inputField.resignFirstResponder()
            inputField.text = ""
            inputField.becomeFirstResponder()
            
        }

        return true
    }
    
    func generateNewWord() -> String {
        if currentList.isEmpty {
            endGame()
            return ""
        }
        guard let randomWord = currentList.randomElement() else {
            //endGame()
            return "no"
            
        }
        
        
        countdownTime = 8
        countdownLabel.text = "\(countdownTime)"
        startCountdown()
        currentList.removeAll { $0 == wordLabel.text}
        
        return randomWord!
    }
    
    
    // Creates a timer that repeats indefinitely with interval 1 sec. Third parameter is a closure.
    // The closure captures a reference to self using [weak self]. This is necessary to avoid a retain cycle.
    // The closure decrements countdownTime by 1, and updates the countdownLabel to show the new value of countdownTime.
    func startCountdown() {

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdownTime -= 1
            self.countdownLabel.text = "\(self.countdownTime)"
            if self.countdownTime == 0 {
                timer.invalidate()
                Game.shared.score -= 1
                self.scoreLabel.text = String(Game.shared.score)
                self.wordLabel.text = self.generateNewWord()
                self.inputField.text = ""
            }
        }
    }
    
    
    func endGame() {
        // Save final score and player name
        UserDefaults.standard.set(Game.shared.score, forKey: "finalScore")
        UserDefaults.standard.set(playerName, forKey: "playerName")
        
        // Show alert with final score
        let alert = UIAlertController(title: "Game Over", message: "Your final score is \(Game.shared.score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "segueToFinalScore", sender: nil)

        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
