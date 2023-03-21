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
    let game = Game(score: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        inputField.delegate = self
        scoreLabel.text = String(game.score)
        countdownLabel.text = "\(countdownTime)"
        wordLabel.text = generateNewWord()
        inputField.text = ""
        

    }
    
    
    
    func textField(_ textField : UITextField, shouldChangeCharactersIn range : NSRange, replacementString string : String) -> Bool {
    
        guard let inputText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if inputText == wordLabel.text {
            textField.text = ""
            game.score += 1
            scoreLabel.text = String(game.score)
            wordLabel.text = generateNewWord()
            inputField.resignFirstResponder()
            inputField.text = ""
            //inputField.becomeFirstResponder()
        }
        
        
        print("shouldChangeCharacters called")
        return true
    }
    
    func generateNewWord() -> String {
        let randomWord = game.wordList.stringList.randomElement()!
        print("generateNewWord called")
        
        countdownTime = 5
        countdownLabel.text = "Time: \(countdownTime)"
        startCountdown()
        
        return randomWord
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.countdownTime -= 1
            self.countdownLabel.text = "\(self.countdownTime)"
            if self.countdownTime == 0 {
                timer.invalidate()
                self.game.score -= 1
                self.scoreLabel.text = String(self.game.score)
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
