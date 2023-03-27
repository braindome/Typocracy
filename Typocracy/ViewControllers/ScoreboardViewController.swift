//
//  ScoreboardViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-24.
//

import UIKit

class ScoreboardViewController: UITableViewController {
    
    
    var scoreboard = [ScoreboardEntry]()
    var entryName : String?
    var entryScore : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the scoreboard from UserDefaults
        if let savedScoreboard = UserDefaults.standard.object(forKey: "scoreboard") as? Data,
            let decodedScoreboard = try? JSONDecoder().decode([ScoreboardEntry].self, from: savedScoreboard) {
            scoreboard = decodedScoreboard
        }

        
        scoreboard.sort { $0.score! > $1.score! }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save the scoreboard to UserDefaults
        let encoder = JSONEncoder()
        if let encodedScoreboard = try? encoder.encode(scoreboard) {
            UserDefaults.standard.set(encodedScoreboard, forKey: "scoreboard")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Add new entry to the scoreboard
        if let name = entryName, let score = entryScore {
            scoreboard.append(ScoreboardEntry(name: name, score: score))
        }
        
        // Sort the scoreboard in decreasing order by score
        scoreboard.sort { $0.score ?? 0 > $1.score ?? 0 }
        
        // Load the scoreboard from UserDefaults
        if let savedScoreboard = UserDefaults.standard.object(forKey: "scoreboard") as? Data,
            let decodedScoreboard = try? JSONDecoder().decode([ScoreboardEntry].self, from: savedScoreboard) {
            scoreboard = decodedScoreboard
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scoreboard.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreEntryCell", for: indexPath)
        
        if let name = scoreboard[indexPath.row].name, let score = scoreboard[indexPath.row].score {
            cell.textLabel?.text = name + "     " + String(score)
        } else {
            cell.textLabel?.text = "N/A"
        }
        
        return cell
    }
    

}
