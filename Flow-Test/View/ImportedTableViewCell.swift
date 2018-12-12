//
//  ImportedTableViewCell.swift
//  Flow-Test
//
//  Created by WorkStation on 12/10/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import UIKit

class ImportedTableViewCell: UITableViewCell {
    
    /**
     * IBOutlet for the view created through Interface Builder
     * Required to change the value at run-time
     **/
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var importedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
