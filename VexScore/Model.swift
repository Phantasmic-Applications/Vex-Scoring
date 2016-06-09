//
//  Model.swift
//  VexScore
//
//  Created by P Mara on 6/4/16.
//  Copyright © 2016 Phantasmic Apps. All rights reserved.
//

import UIKit
import CoreData

class Model: NSManagedObject {
    
    @NSManaged var teamnum: String
    @NSManaged var teamauton: String
    @NSManaged var robot: String
    @NSManaged var rank: String
    @NSManaged var record: String
    
    

}
