//
//  Team.swift
//  VexScoring
//
//  Created by Andrew Turley on 2/28/16.
//  Copyright © 2016 Phantasmic Applications. All rights reserved.
//

import Foundation

class Team : NSObject, NSCoding {
    var teamName : String?
    var rank : Int?
    var num : String?
    var scorePoints : Int?
    var winPoints : Int?
    var wins : Int?
    var losses : Int?
    var ties : Int?
    var sku : String?
    var code : String?
    var id : Int?
    var updated : String?
    var division : Int?
    var deleted : Int?
    var notes : String?
    var location : String?
    
    func setName(newName: String) {self.teamName = newName}
    
    func getName() -> String {return teamName!}
    
    func getRank() -> Int {return rank!}
    
    func getNumber() -> String {return num!}
    
    func getSP() -> Int {return scorePoints!}
    
    func getWP() -> Int {return winPoints!}
    
    func getWins() -> Int {return wins!}
    
    func getLosses() -> Int {return losses!}
    
    func getTies() -> Int {return ties!}
    
    func getLocation() -> String {return location!}
    
    func getNotes() -> String {return notes!}
    
    func setRank(newRank: Int) {rank = newRank}
    
    func setNumber(newNumber: String) {num = newNumber}
    
    func setSP(newSP: Int) {scorePoints = newSP}
    
    func setWP(newWP: Int) {winPoints = newWP}
    
    func setWins(newWin: Int) {wins = newWin}
    
    func losses(newLoss: Int) {losses = newLoss}
    
    func ties(newTie: Int) {ties = newTie}
    
    init(name: String, location: String, notes: String) {
        self.teamName = name
        self.location = location
        self.notes = notes
    }
    
    override init() {
        teamName = ""
        rank = -1
        num = ""
        scorePoints = -1
        winPoints = -1
        wins = -1
        losses = -1
        ties = -1
    }
    
    required convenience init(coder aDecoder: NSCoder) {
//        let id = aDecoder.decodeIntegerForKey("id")
//        let name = aDecoder.decodeObjectForKey("name") as! String
//        let shortname = aDecoder.decodeObjectForKey("shortname") as! String
        self.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeInteger(id, forKey: "id")
//        aCoder.encodeObject(name, forKey: "name")
//        aCoder.encodeObject(shortname, forKey: "shortname")
    }
}