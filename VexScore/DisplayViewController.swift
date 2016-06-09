//
//  DisplayViewController.swift
//  VexScore
//
//  Created by P Mara on 6/5/16.
//  Copyright © 2016 Phantasmic Apps. All rights reserved.
//

import UIKit
import CoreData


class DisplayViewController: UIViewController {
    @IBOutlet weak var TeamRank: UILabel!
    @IBOutlet weak var TeamNum: UILabel!
    @IBOutlet weak var TeamRecord: UILabel!
    @IBOutlet weak var TeamAuton: UILabel!
    @IBOutlet weak var TeamLiftType: UILabel!
    @IBOutlet weak var TeamName: UILabel!
    @IBOutlet weak var AutonomousPoints: UILabel!
    @IBOutlet weak var ScorePoints: UILabel!
    
    var teamnum: String = ""
    var teamauton: String = ""
    var robot: String = ""
    var record: String = ""
    var rank: String = ""
    var autonomouspoints: String = ""
    var scorepoints: String = ""
    var teamname: String = ""
    
    var csvString = ""
    var csv : CSV?
    
    var masterTeams = [Team]()
    
    var existingItem: NSManagedObject!
    
    override func viewDidLoad() {
        TeamNum.text = existingItem.valueForKey("teamnum") as? String
        TeamAuton.text = existingItem.valueForKey("teamauton") as? String
        TeamLiftType.text = existingItem.valueForKey("robot") as? String
        TeamRecord.text = existingItem.valueForKey("record") as? String
        TeamRank.text = existingItem.valueForKey("rank") as? String
        TeamName.text = existingItem.valueForKey("teamname") as? String
        AutonomousPoints.text = existingItem.valueForKey("autonomouspoints") as? String
        ScorePoints.text = existingItem.valueForKey("scorepoints") as? String
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh(sender: AnyObject) {
        downloadCSV()
    }
    
    func searchForTeam() -> Team? {
        let teamNumber = TeamNum.text
        for team in masterTeams {
            if teamNumber == team.num {
                return team
            }
        }
        return nil
    }
    
    func downloadCSV() {
        let url = NSURL(string: "http://ajax.robotevents.com/tm/results/rankings/?format=csv&sku=RE-VRC-13-8611&div=1")
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: NSASCIIStringEncoding) as String!
                    
                    self.csvString = urlContent
                    
                    self.csvString = self.csvString.stringByReplacingOccurrencesOfString("\"", withString: "")
                    
                    self.csv = CSV(string: self.csvString)
                    
                    self.csv!.columns.popFirst()
                    self.csv!.columns.popFirst()
                    
                    self.masterTeams = [Team]()
                    
                    for index in 0..<self.csv!.rows.count {
                        self.masterTeams.append(Team())
                        for data in 0..<self.csv!.rows[index].count {
                            switch self.csv!.rows[index].first!.0 {
                            case "rank":
                                self.masterTeams[index].rank = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "ties":
                                self.masterTeams[index].ties = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "wins":
                                self.masterTeams[index].wins = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "losses":
                                self.masterTeams[index].losses = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "teamname":
                                self.masterTeams[index].teamName = self.csv!.rows[index].first!.1
                                self.csv!.rows[index].popFirst()
                            case "sp":
                                self.masterTeams[index].scorePoints = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "ap":
                                self.masterTeams[index].autonomousPoints = Int(self.csv!.rows[index].first!.1)
                                self.csv!.rows[index].popFirst()
                            case "teamnum":
                                self.masterTeams[index].num = self.csv!.rows[index].first!.1
                                self.csv!.rows[index].popFirst()
                            default:
                                self.csv!.rows[index].popFirst()
                            }
                        }
                    }
                    
                    if let inputTeam = self.searchForTeam() {
                        self.TeamRecord.text = "\(inputTeam.wins!)-\(inputTeam.losses!)-\(inputTeam.ties!)"
                        self.TeamRank.text = String(inputTeam.rank!)
                        //self.AutonomousPoints.text = String(inputTeam.autonomousPoints!)
                        self.ScorePoints.text = String(inputTeam.scorePoints!)
                    }
                }
                else {
                    print(error)
                    self.csvString = "ERROR"
                }
            })
            task.resume()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditInfo" {
            let ViewCon: AddViewController = segue.destinationViewController as! AddViewController
            
            ViewCon.teamnum = existingItem.valueForKey("teamnum") as! String
            ViewCon.teamauton = existingItem.valueForKey("teamauton") as! String
            ViewCon.robot = existingItem.valueForKey("robot") as! String
            
            ViewCon.editingItem = existingItem
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
    }
}
