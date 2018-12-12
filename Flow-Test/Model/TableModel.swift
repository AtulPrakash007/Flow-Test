//
//  TableModel.swift
//  Flow-Test
//
//  Created by WorkStation on 12/11/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import Foundation

/**
 * Read dictionary from the JSON and store in an array
 * Date time have been breaked into date and time and stored as String
**/

struct TableModel {
    var type: String = ""
    var title: String = ""
    var date: String = ""
    var time: String = ""
    var location: String = ""
    var status: Int = 0
    var groupName: String = ""
    var clientName: String = ""
}

/**
 * Store the Grouped By Date value of JSON
*/

struct Objects {
    var sectionName : String
    var sectionObjects : [TableModel]
}
