//
//  TableViewController.swift
//  VexScore
//
//  Created by P Mara on 6/4/16.
//  Copyright © 2016 Phantasmic Apps. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    var List: Array<AnyObject> = []
    
    var url: String = ""
    

    override func viewDidLoad() {
       self.navigationItem.setHidesBackButton(true, animated:true);
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return List.count
        
        
    }

    
    override func viewDidAppear(animated: Bool) {
        
        let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        
        let Context: NSManagedObjectContext = AppDel.managedObjectContext
        
        
        
        let request = NSFetchRequest(entityName: "TeamList1")
        
        List = try! Context.executeFetchRequest(request)
        tableView.reloadData()
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell: TableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCell
        
        let data: NSManagedObject = List[indexPath.row] as! NSManagedObject
        
        cell.TeamNum?.text = data.valueForKey("teamnum")  as? String
        cell.RobotInfo?.text = data.valueForKey("robot") as? String
        cell.TeamAuton?.text = data.valueForKey("teamauton") as? String
        cell.TeamRank?.text = data.valueForKey("rank") as? String
        cell.TeamRecord?.text = data.valueForKey("record") as? String
        cell.TeamName?.text = data.valueForKey("teamname") as? String
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        
        
        return cell
        
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let Context: NSManagedObjectContext = AppDel.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            Context.deleteObject(List[indexPath.row] as! NSManagedObject)
            List.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
        var error: NSError? = nil
        
        do {
            
            try Context.save()
            
        } catch let error1 as NSError {
            
            error = error1
            print(error)
            abort()
            
        }
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowInfo" {
            
            let selectedItem: NSManagedObject = List[self.tableView.indexPathForSelectedRow!.row] as! NSManagedObject
            
            let ViewCon: DisplayViewController = segue.destinationViewController as! DisplayViewController
            
            ViewCon.teamnum = selectedItem.valueForKey("teamnum") as! String
            ViewCon.teamauton = selectedItem.valueForKey("teamauton") as! String
            ViewCon.robot = selectedItem.valueForKey("robot") as! String
            ViewCon.rank = selectedItem.valueForKey("rank") as! String
            ViewCon.record = selectedItem.valueForKey("record") as! String
            
            
            ViewCon.existingItem = selectedItem
            
            
            
            
            
            
        }
      
    }
    

}
