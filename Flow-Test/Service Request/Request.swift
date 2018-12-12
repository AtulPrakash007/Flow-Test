//
//  Request.swift
//  Flow-Test
//
//  Created by WorkStation on 12/11/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import Foundation

/**
 * Read Local JSON File
 * Parameter: FileName and file extension as String
 * Response: Dictionary or Array based on the file type
 * Response: Error, in case file is not readable
**/

class Request: NSObject {
    static let sharedInstance = Request()
    
    func readJson(file name: String, of type: String, completion: @escaping (Dictionary<String, Any>, Array<Any>, Error?)->() ) {
        
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    completion (object , [], nil)
                } else if let object = json as? [Any] {
                    // json is an array
                    completion ([:], object, nil)
                } else {
                    print("JSON is invalid")
                    completion ([:], [], nil)
                }
                
            } catch let error {
                completion ([:], [], error)
            }
        }
    }
}
