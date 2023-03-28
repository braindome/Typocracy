//
//  ScoreboardViewController.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-24.
//

import UIKit

class ScoreboardViewController: UITableViewController {
    
    var scoreboard = [[String: Any]]()
    
    private let defaults = UserDefaults.standard
    
    var entryName : String?
    var entryScore : Int?
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadScoreboard()
        
        print("Player name transported to scoreboard vc: \(entryName!)")
        
                
        if let name = entryName, let score = entryScore {
             addEntry(name: name, score: score)
         }
        
        scoreboard.sort { ($0["score"] as? Int ?? 0) > ($1["score"] as? Int ?? 0) }
        tableView.reloadData()
        
        print(scoreboard)
        

    }
    
    private func loadScoreboard() {
        if let savedScoreboard = defaults.object(forKey: "scoreboard") as? [[String: Any]] {
            scoreboard = savedScoreboard
        } else {
            scoreboard = []
        }
    }
    
    private func saveScoreboard() {
        defaults.set(scoreboard, forKey: "scoreboard")
    }

    func addEntry(name: String, score: Int) {
        
        let entry = ["name" : name, "score" : score] as [String : Any]
        scoreboard.append(entry)
        scoreboard.sort { ($0["score"] as? Int ?? 0) > ($1["score"] as? Int ?? 0) }
        tableView.reloadData()
        saveScoreboard()
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
        let entry = scoreboard[indexPath.row]
        let name = entry["name"] as? String ?? "N/A"
        let score = entry["score"] as? Int ?? 0
        
        cell.textLabel?.text = "\(name)     \(score)"
        
        
        return cell
    }
    

}
