//
//  WordList.swift
//  Typocracy
//
//  Created by Antonio on 2023-03-20.
//

import Foundation

class WordList {

    var stringList = [String](arrayLiteral: "accept", "accidentally", "acquire", "ambulance", "ancient", "appearance", "appointment", "arithmetic", "audience", "autumn", "beautifully", "beliefs", "blown", "bough", "bows", "calendar", "canyon", "capable", "capacity", "caution", "ceiling", "champion", "choir", "cleanse", "combination", "comfortable", "community", "complain", "concentration", "concern", "connection", "constitution", "contagious", "conversation", "cooperation", "correct", "coupon", "creative", "creature", "crisis", "culture", "curious", "dangerous", "decision", "demonstrate", "denominator", "department", "departure", "depth", "descendant", "disagreement", "disastrous", "discussion", "distance", "distributed", "earliest", "echoes", "edition", "educate", "electricity", "element", "elevator", "emergency", "employer", "emptiness", "encouragement", "encyclopedia", "entire", "entrance", "envelope", "equator", "especially", "establish", "example", "excellent", "excitement", "exercise", "experience", "exterior", "familiar", "faucet", "fierce", "fireproof", "following", "forgetting", "forgiveness", "fossil", "freight", "frighten", "fuel", "further", "gallon", "gaze", "gesture", "governor", "graduation", "grateful", "grief", "halves", "hamburger", "hangar", "hanger", "happiness", "headache", "heroes", "history", "honorable", "horizon", "hunger", "hyphen", "ignore", "imagination", "immediate", "importance", "improvement")
    
    init() {

        stringList.append("pear")
        stringList.append("apple")
        stringList.append("kiwi")
        stringList.append("papaja")
        stringList.append("avocado")
    }
    
    func getList(stringList: [String], n: Int) -> [String] {
        var randomElements: [String] = []
        var copy = stringList
        
        for _ in 0..<n {
            let randomIndex = Int.random(in: 0..<copy.count)
            randomElements.append(copy[randomIndex])
            copy.remove(at: randomIndex)
        }
        
        return randomElements
    }
    
}
