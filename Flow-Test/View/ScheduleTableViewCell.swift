//
//  ScheduleTableViewCell.swift
//  Flow-Test
//
//  Created by WorkStation on 12/10/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    /**
     * IBOutlet for the view created through Interface Builder
     * Required to change the value at run-time
    **/
    
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var scheduleTimeLabel: UILabel!
    @IBOutlet weak var scheduleStatusLabel: UILabel!
    @IBOutlet weak var scheduleMeetingLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var sepratorLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
