//
//  AddViewController.swift
//  VexScore
//
//  Created by P Mara on 6/4/16.
//  Copyright © 2016 Phantasmic Apps. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var TextFieldTeamNum: UITextField!
    @IBOutlet weak var TextFieldAuton: UITextField!
    @IBOutlet weak var TextFieldRobot: UITextField!
    
    var teamnum: String = ""
    var teamauton: String = ""
    var robot: String = ""
    
    var csv : CSV?
    var csvString = ""
    var masterTeams = [Team]()
    
    
    var editingItem: NSManagedObject!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if (editingItem != nil) {
          
            TextFieldRobot.text = editingItem.valueForKey("robot") as? String
            TextFieldAuton.text = editingItem.valueForKey("teamauton") as? String
            TextFieldTeamNum.text = editingItem.valueForKey("teamnum") as? String
            
            
        }
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func DismissKeyboard(sender: AnyObject) {
        self.resignFirstResponder()
    }
    
    
    @IBAction func Save(sender: AnyObject) {
        
        let Appdel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let theContext: NSManagedObjectContext = Appdel.managedObjectContext
        let theEnt = NSEntityDescription.entityForName("TeamList", inManagedObjectContext: theContext)
        
        
        if (editingItem != nil) {
            
            editingItem.setValue(TextFieldTeamNum.text as String?, forKey: "teamnum")
            editingItem.setValue(TextFieldAuton.text as String?, forKey: "teamauton")
            editingItem.setValue(TextFieldRobot.text as String?, forKey: "robot")
            
            
        } else {
            let newitem = Model(entity: theEnt!, insertIntoManagedObjectContext: theContext)
            
            newitem.robot = TextFieldRobot.text!
            newitem.teamauton = TextFieldAuton.text!
            newitem.teamnum = TextFieldTeamNum.text!
            downloadCSV()
        }
        
        do {
            
            try theContext.save()
            
        } catch _ {
            
        }
        
        self.navigationController?.popViewControllerAnimated(true)
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
                    
                    for index in 0..<self.csv!.rows.count {
                        for data in 0..<self.csv!.rows[index].count {
                            switch self.csv!.rows[index].first!.0 {
                                case "rank":
                                    self.csv!.rows[index].popFirst()
                                case "ties":
                                    self.csv!.rows[index].popFirst()
                                case "wins":
                                    self.csv!.rows[index].popFirst()
                                case "losses":
                                    self.csv!.rows[index].popFirst()
                                case "teamname":
                                    self.csv!.rows[index].popFirst()
                                case "sp":
                                    self.csv!.rows[index].popFirst()
                                case "ap":
                                    self.csv!.rows[index].popFirst()
                                default:
                                    self.csv!.rows[index].popFirst()
                            }
                        }
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
}
