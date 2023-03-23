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
    var countdownTime = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.delegate = self
        scoreLabel.text = "Score: \(Game.shared.score)"
        countdownLabel.text = "\(countdownTime)"
        wordLabel.text = generateNewWord()
        inputField.text = ""
    
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
            //inputField.becomeFirstResponder()
        }
        
        
        print("shouldChangeCharacters called")
        return true
    }
    
    func generateNewWord() -> String {
        let randomWord = Game.shared.wordList.stringList.randomElement()!
        print("generateNewWord called")
        
        countdownTime = 5
        countdownLabel.text = "\(countdownTime)"
        startCountdown()
        
        return randomWord
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
                Game.shared.score -= 1
                self.scoreLabel.text = String(Game.shared.score)
                self.wordLabel.text = self.generateNewWord()
                self.inputField.text = ""
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
