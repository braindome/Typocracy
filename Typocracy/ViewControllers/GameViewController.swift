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
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            return
        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = initialViewController
            window.makeKeyAndVisible()
        }
        
    }
    
    var gameLength : Int?
    var playerName : String?
    var game : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGradientBackground(colors: [UIColor.red, UIColor.yellow], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
                
        game = Game(score: 0, listLength: gameLength, playerName: playerName)
    
        inputField.delegate = self
        scoreLabel.text = ""
        
        game!.countdownUpdateHandler = { [weak self] remainingTime in
            self?.countdownLabel.text = "\(remainingTime)"
            if remainingTime <= 3 {
                self?.countdownLabel.textColor = .red
            }
            if remainingTime == 0 {
                self?.game!.score -= 1
                self?.countdownLabel.textColor = .black
                self?.scoreLabel.text = String(self?.game!.score ?? 0)
                self?.wordLabel.text = self?.game!.generateNewWord()
                if let inputText = self?.inputField.text, inputText != "" {
                    UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState], animations: {
                        self?.inputField.backgroundColor = .red
                    }, completion: { _ in
                        self?.inputField.backgroundColor = .white
                        self?.inputField.text = ""
                    })
                }
            }
        }
        
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
        
        if inputText == wordLabel.text {
            textField.backgroundColor = .green
            print("Input text is correct")
            game!.score += 1
            updateLabels()
            countdownLabel.textColor = .black
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {textField.backgroundColor = .white})
        
        if game!.currentList.count == 0 {
            game!.countdownTimer?.invalidate()
            endGameAlert()
        }
        return true
    }
    
    private func updateLabels() {
        scoreLabel.text = String(game!.score)
        wordLabel.text = game!.generateNewWord()
        DispatchQueue.main.async {
            self.inputField.text = ""
            self.inputField.backgroundColor = .white
        }
    }
    
    private func endGameAlert() {
        
        // Show alert with final score, sends to Final Score 
        let alert = UIAlertController(title: "Game Over", message: "Your final score is \(game!.score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.performSegue(withIdentifier: "segueToFinalScore", sender: nil)

        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
