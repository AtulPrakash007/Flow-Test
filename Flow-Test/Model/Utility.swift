//
//  Utility.swift
//  Flow-Test
//
//  Created by WorkStation on 12/10/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import Foundation
import UIKit

/**
 * Helper Class
*/

class Utility: NSObject {
    
    /**
     * Get Date Time
     * Parameter: time in milliseconds i.e. Double value & what required date or time
     * Response: Date; if passed bool true. Format "Thr 12 Dec 2018"
     * Response: Time; if bool passed as false. Format "22:59" i.e. 24 hour format
    **/
    
    class func convertDateTime(from milliSeconds: Double, isDate: Bool) -> String {
        var timeString: String = ""
        let date = Date(timeIntervalSince1970: milliSeconds/1000)
        let dateFormatter = DateFormatter()
        
        if isDate {
            dateFormatter.dateFormat = "EE dd MMM YYYY"
            timeString = dateFormatter.string(from: date)
        }else {
            dateFormatter.dateFormat = "HH:mm"
            timeString = dateFormatter.string(from: date)
        }
        return timeString
    }
}
