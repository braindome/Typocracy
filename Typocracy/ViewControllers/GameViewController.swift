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
    
    var gameLength : Int?
    var playerName : String?
    var game : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        game = Game(score: 0, listLength: gameLength, playerName: playerName)
    
        inputField.delegate = self
        scoreLabel.text = "Score"
        
        game!.countdownUpdateHandler = { [weak self] remainingTime in
            self?.countdownLabel.text = "\(remainingTime)"        }
        
        wordLabel.text = game!.generateNewWord()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFinalScore" {
            if let finalScoreVC = segue.destination as? FinalScoreViewController {
                finalScoreVC.name = playerName
                finalScoreVC.score = game?.score ?? 0
            }
        }
    }
    
    func textField(_ textField : UITextField, shouldChangeCharactersIn range : NSRange, replacementString string : String) -> Bool {
    
        // Nil check (acts as if...)
        guard let inputText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if inputText.contains(wordLabel.text!) {
            game!.score += 1
            wordLabel.text = game!.generateNewWord()
            textField.text = ""

        } else if game!.countdownTime == 0 {
            game!.score -= 1
            wordLabel.text = game!.generateNewWord()
            textField.text = ""

        }
        
        scoreLabel.text = String(game!.score)
        if game!.currentList.count == 0 {
            game!.countdownTimer?.invalidate()
            endGameAlert()
        }
        return true
    }
    
    func endGameAlert() {
        
        // Show alert with final score, sends to Final Score 
        let alert = UIAlertController(title: "Game Over", message: "Your final score is \(game!.score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "segueToFinalScore", sender: nil)

        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
