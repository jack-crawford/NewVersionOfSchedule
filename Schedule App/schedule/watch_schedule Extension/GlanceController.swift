//
//  GlanceController.swift
//  watch_schedule Extension
//
//  Created by Jack Crawford on 3/14/16.
//  Copyright © 2016 Jack Crawford. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    var timer = NSTimer()
    
    @IBOutlet var letter_day_label: WKInterfaceLabel!
    @IBOutlet var next_mod_label: WKInterfaceLabel!
    @IBOutlet var mod_time_label: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface object
    // Configure interface object
    timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "loadweb", userInfo: nil, repeats: true)
}
func loadweb(){
    if let url = NSURL(string: "http://hollandhall.net/hhmods/mobile.php") {
        do {
            let contents = try! NSString(contentsOfURL: url, usedEncoding: nil)
            let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            do {
                let todaysDate:NSDate = NSDate()
                let dateFormatter:NSDateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE"
                let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
                
                var error:NSError? = nil
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) {
                    if let dict = jsonObject as? NSDictionary {
                        print(dict)
                        let cyc = dict["cycleval"] as? String
                        let mod = dict["mod"] as? String
                        let mod_time = dict["modstart"] as? String
                        if mod == "19" {
                            letter_day_label.setText("Day")
                            next_mod_label.setText("ends at")
                            mod_time_label.setText("3:10!")
                        } else {
                            if mod == "good morning" {
                                next_mod_label.setText("Morning")
                                letter_day_label.setText("Good")
                                mod_time_label.setText("Dutch")
                                
                            } else {
                                if DateInDayFormat == "Sat" || DateInDayFormat == "Sun" {
                                    //happy weekend message
                                } else {
                                    if mod == "over"{
                                        next_mod_label.setText("is")
                                        letter_day_label.setText("School")
                                        mod_time_label.setText("Out!")
                                    } else {
                                        if mod == "no school" {
                                            next_mod_label.setText("School")
                                            letter_day_label.setText("No")
                                            mod_time_label.setText("Today!")
                                        } else {
                                            letter_day_label.setText(cyc);
                                            next_mod_label.setText(mod);
                                            mod_time_label.setText(mod_time);
                                        }
                                    }
                                }
                            }
                        }
                    }else {
                        print("not a dictionary")
                    }
                } else {
                    print("Could not parse JSON: \(error!)")
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}


    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
