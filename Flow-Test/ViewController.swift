//
//  ViewController.swift
//  Flow-Test
//
//  Created by WorkStation on 12/10/18.
//  Copyright © 2018 Atul Prakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /**
     * IBOutlet for the view created through Interface Builder
     * Required to change the value at run-time
    **/
    
    @IBOutlet weak var tableView: UITableView!
    
    /**
     * Declared Variable of the Class
    **/
    
    var modelArray = [TableModel]()
    var modelDict = [String:[TableModel]]()
    var objectArray = [Objects]()
    
    /**
     * Defile all the Color codes
    **/
    
    let inviteColor: UIColor = UIColor.init(hex: 0xF1C40D, alpha: 1.0)
    let attendColor: UIColor = UIColor.init(hex: 0x77CB7F, alpha: 1.0)
    let notAttendColor: UIColor = UIColor.init(hex: 0xCBCBCB, alpha: 1.0)
    let black: UIColor = UIColor.black
    let darkGrey: UIColor = UIColor.darkGray
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Utility.convertDateTime(from: 1541257200000, isDate: true))
        print(Utility.convertDateTime(from: 1541257200000, isDate: false))
        
        registerTableViewCell()
        callJson(with: kFileName, and: kFileType)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Register Different UITableViewCell
    func registerTableViewCell(){
        
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.indicatorStyle = UIScrollViewIndicatorStyle.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: ScheduleTableViewCell.self),bundle: nil), forCellReuseIdentifier:String(describing: ScheduleTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: ImportedTableViewCell.self),bundle: nil), forCellReuseIdentifier:String(describing: ImportedTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: HolidayTableViewCell.self),bundle: nil), forCellReuseIdentifier:String(describing: HolidayTableViewCell.self))
    }
    
    //MARK:- Read Local File
    
    /**
     * Call this function to read JSON
     * Parameter: filename and file extension as String
     * Response: Nothing
    **/
    
    func callJson(with fileName: String, and type: String) {
        Request.sharedInstance.readJson(file: kFileName, of: kFileType) { (dict, array, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("error is not nil")
                    return
                }
                
                guard dict.isEmpty else {
                    print("Dict is not empty")
                    self.parseJsonData(from: false, then: [], else: dict)
                    return
                }
                
                guard array.count == 0 else {
                    print("array is not empty")
                    self.parseJsonData(from: true, then: array, else: [:])
                    return
                }
            }
        }
    }
    
    //MARK: - Parse JSON Array
   
    /**
     * Parse Json data fetched from the Request
     * Parameter: is the data is Array as Bool, data AS Array or Data AS Dictionary
     * Response: Nothing
    **/
    
    func parseJsonData(from isArray:Bool, then array: Array<Any>, else dict: Dictionary<String, Any>){
        
        if array.count > 0 {
            for index in 0...array.count-1 {
                let dict = array[index] as! [String: AnyObject]
//                let result: String = dict[kClientName] as? String ?? ""
//                print(result)
                
                let tempData = TableModel(type: dict[kType] as? String ?? "",
                                          title: dict[kTitle] as? String ?? "",
                                          date: Utility.convertDateTime(from: dict[kDatetime] as? Double ?? 0, isDate: true) ,
                                          time: Utility.convertDateTime(from: dict[kDatetime] as? Double ?? 0, isDate: false),
                                          location: dict[kLocation] as? String ?? "",
                                          status: dict[kStatus] as? Int ?? 0,
                                          groupName: dict[kGroupName] as? String ?? "",
                                          clientName: dict[kClientName] as? String ?? "")
                modelArray.append(tempData)
                
            }
        }
        
        /**
         * Group the Data using the Date
        **/
        
        modelDict = Dictionary(grouping: modelArray, by: {$0.date})
        print(modelDict.keys.count)
        
        for (key, value) in modelDict {
            print("\(key) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        
        self.tableView.reloadData()
    }
    
    /**
     * Hide Status Bar
    **/
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let scheduleCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScheduleTableViewCell.self), for: indexPath) as! ScheduleTableViewCell
        
        let importedCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImportedTableViewCell.self), for: indexPath) as! ImportedTableViewCell
        
        let holidayCell = tableView.dequeueReusableCell(withIdentifier: String(describing: HolidayTableViewCell.self), for: indexPath) as! HolidayTableViewCell
        
        let cellData = objectArray[indexPath.section].sectionObjects[indexPath.row]

        switch cellData.type {
        case "SCHEDULED":
            scheduleCell.scheduleTimeLabel.text = cellData.time
            
            switch cellData.status {
            case 0:
                scheduleCell.colorLabel.backgroundColor = notAttendColor
                scheduleCell.scheduleStatusLabel.text = "NOT ATTENDING"
                scheduleCell.scheduleStatusLabel.textColor = notAttendColor
                
            case 1:
                scheduleCell.colorLabel.backgroundColor = attendColor
                scheduleCell.scheduleStatusLabel.text = "ATTENDING"
                scheduleCell.scheduleStatusLabel.textColor = attendColor
                
            case 2:
                scheduleCell.colorLabel.backgroundColor = inviteColor
                scheduleCell.scheduleStatusLabel.text = "INVITED"
                scheduleCell.scheduleStatusLabel.textColor = inviteColor
                
            default:
                break
            }
            
            scheduleCell.scheduleMeetingLabel.text = cellData.title
            scheduleCell.groupNameLabel.text = cellData.groupName
            scheduleCell.clientNameLabel.text = cellData.clientName
            scheduleCell.locationLabel.text = cellData.location
            
            switch cellData.status {
            case 0:
                scheduleCell.scheduleTimeLabel.textColor = notAttendColor
                scheduleCell.scheduleMeetingLabel.textColor = notAttendColor
                scheduleCell.groupNameLabel.textColor = notAttendColor
                scheduleCell.sepratorLabel.textColor = notAttendColor
                scheduleCell.clientNameLabel.textColor = notAttendColor
                scheduleCell.locationLabel.textColor = notAttendColor
            default:
                scheduleCell.scheduleTimeLabel.textColor = black
                scheduleCell.scheduleMeetingLabel.textColor = black
                scheduleCell.groupNameLabel.textColor = darkGrey
                scheduleCell.sepratorLabel.textColor = darkGrey
                scheduleCell.clientNameLabel.textColor = darkGrey
                scheduleCell.locationLabel.textColor = darkGrey
            }
            cell = scheduleCell
            
        case "IMPORTED":
            importedCell.timeLabel.text = cellData.time
            importedCell.importedLabel.text = cellData.title
            cell = importedCell
            
        case "HOLIDAY":
            cell = holidayCell
            
        default:
            break
        }
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return objectArray[section].sectionName
//    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 11, width: tableView.frame.size.width, height: 21))
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = objectArray[section].sectionName
        label.textAlignment = .center
        view.addSubview(label)
        view.backgroundColor = UIColor.init(hex: 0xF7F7F7, alpha: 1.0)
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

