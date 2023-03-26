//
//  FinalScoreViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-21.
//

import UIKit

class FinalScoreViewController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finalScoreLabel.text = "Final Score:\n\(String(describing: Game.shared.playerName)), \(Game.shared.score) pts"
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "highestScoresSegue" {
            let destination = segue.destination as! ScoreboardViewController
            destination.name = Game.shared.playerName
            destination.score = String(Game.shared.score)
        }
    }
    

}
