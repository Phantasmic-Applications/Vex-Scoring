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
    
    
    @IBOutlet weak var TeamNum: UILabel!
    @IBOutlet weak var TeamRecord: UILabel!
    @IBOutlet weak var TeamAuton: UILabel!
    @IBOutlet weak var TeamLiftType: UILabel!
    
    var teamnum: String = ""
    var teamauton: String = ""
    var robot: String = ""
    
    
    var existingItem: NSManagedObject!
    
    
    
    

    override func viewDidLoad() {
        
        TeamNum.text = existingItem.valueForKey("teamnum") as? String
        TeamAuton.text = existingItem.valueForKey("teamauton") as? String
        TeamLiftType.text = existingItem.valueForKey("robot") as? String
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
