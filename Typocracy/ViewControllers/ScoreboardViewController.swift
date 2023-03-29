//
//  ScoreboardViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-24.
//

import UIKit

class ScoreboardViewController: UITableViewController {
    
    //var scoreboard = [[String: Any]]()
    var scoreboard = Scoreboard()

    private let defaults = UserDefaults.standard
    
    var entryName : String?
    var entryScore : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadScoreboard()
        scoreboard.load()
        
        print("Player name transported to scoreboard vc: \(entryName!)")
        
                
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreEntryCell", for: indexPath)
        let entry = scoreboard.entries[indexPath.row]
        let name = entry.name
        let score = entry.score
        let date = entry.date
                
        // Format the text using attributed strings
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let nameAttrs = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        let scoreAttrs = [NSAttributedString.Key.foregroundColor: UIColor.red,
                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        let nameString = NSMutableAttributedString(string: name!, attributes: nameAttrs)
        let scoreString = NSMutableAttributedString(string: " \(score!)", attributes: scoreAttrs)
        let dateString = NSAttributedString(string: "  \(date!)", attributes: attrs)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(nameString)
        attributedString.append(scoreString)
        attributedString.append(dateString)
        
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
    

}
