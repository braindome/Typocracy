//
//  ScoreboardEntry.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-27.
//

import Foundation

struct ScoreboardEntry : Codable {
    var name : String?
    var score : Int?
    var date : String?
    
    init(name: String? = nil, score: Int? = nil, date: Date = Date()) {
        
        self.name = name
        self.score = score
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale.current
        self.date = dateFormatter.string(from: date)
        
    }
    
}
