//
//  FinalScoreViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-21.
//

import UIKit

class FinalScoreViewController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
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
    var score : Int?
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGradientBackground(colors: [UIColor.green, UIColor.orange], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        
        if let name = name, let score = score {
            // Use the unwrapped values of name and score here
            print("Player name: \(name)")
            print("Player score: \(score)")
        } else {
            // Handle the case where either name or score is nil
            print("Player name or score is nil")
        }
        

        if let name = name, let score = score {
            finalScoreLabel.text = "Final Score:\n " + name + ", " + String(score)
        } else {
            // Handle the case where name or score is nil
            finalScoreLabel.text = "Final Score: N/A"
        }
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "highestScoresSegue" {
            let destination = segue.destination as! ScoreboardViewController
            destination.entryName = name
            destination.entryScore = score
        }
    }
    

}
