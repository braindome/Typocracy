//
//  Scoreboard.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-29.
//

import Foundation

class Scoreboard {
    var entries: [ScoreboardEntry] = []

    func addEntry(_ entry: ScoreboardEntry) {
        entries.append(entry)
        entries.sort { $0.score! > $1.score! }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "scoreboard"),
            let decodedEntries = try? JSONDecoder().decode([ScoreboardEntry].self, from: data) {
            entries = decodedEntries
        }
    }

    func save() {
        if let encodedEntries = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedEntries, forKey: "scoreboard")
        }
    }
    
    func reset() {
        entries.removeAll()
    }

    enum CodingKeys: String, CodingKey {
        case entries
    }
}


