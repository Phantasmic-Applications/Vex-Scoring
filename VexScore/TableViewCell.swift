//
//  TableViewCell.swift
//  VexScore
//
//  Created by P Mara on 6/4/16.
//  Copyright © 2016 Phantasmic Apps. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var TeamNum: UILabel!
    @IBOutlet weak var TeamAuton: UILabel!
    @IBOutlet weak var RobotInfo: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
