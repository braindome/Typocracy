//
//  ScoreboardViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-24.
//

import UIKit

class ScoreboardViewController: UITableViewController {
    
    var scoreboard = Scoreboard()

    private let defaults = UserDefaults.standard
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
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
    
    var entryName : String?
    var entryScore : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        scoreboard.load()
        
        // Uncomment to reset the scoreboard.
        //scoreboard.reset()

 
        if let name = entryName, let score = entryScore {
            scoreboard.addEntry(ScoreboardEntry(name: name, score: score))
            tableView.reloadData()
            scoreboard.save()
        }
        
        scoreboard.entries.sort { $0.score ?? 0 > $1.score ?? 0 }
        print(scoreboard.entries)
        tableView.reloadData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scoreboard.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        let entry = scoreboard.entries[indexPath.row]
        let name = entry.name
        let score = entry.score
        let date = entry.date
                
        // Format the text using attributed strings
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let nameAttrs = [NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        var scoreAttrs = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        if score! < 0 { scoreAttrs = [NSAttributedString.Key.foregroundColor: UIColor.red,
                                     NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]}
        
        let nameString = NSMutableAttributedString(string: name!, attributes: nameAttrs)
        let scoreString = NSMutableAttributedString(string: " \(score!)", attributes: scoreAttrs)
        let dateString = NSAttributedString(string: "  \(date!)", attributes: attrs)
        
        cell.nameCellLabel.attributedText = nameString
        cell.scoreCellLabel.attributedText = scoreString
        cell.dateCellLabel.attributedText = dateString
        
        return cell
    }
    
    /*private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "TableViewCell",bundle: nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier: "TableViewCell")
        
    }*/
    

}
