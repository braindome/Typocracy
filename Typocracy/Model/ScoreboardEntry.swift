//
//  ScoreboardEntry.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-27.
//

import Foundation

struct ScoreboardEntry : Decodable, Encodable {
    var name : String?
    var score : Int?
}
