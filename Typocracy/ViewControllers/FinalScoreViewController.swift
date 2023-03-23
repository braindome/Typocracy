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

        finalScoreLabel.text = "Final Score:\n\(Game.shared.score)"
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
