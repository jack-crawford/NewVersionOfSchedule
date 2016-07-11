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
        loadweb()
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                self.timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "loadweb", userInfo: nil, repeats: true)
            }
        }
    }
func loadweb(){
    print("started loadweb");
    if let url = NSURL(string: "http://hollandhall.net/hhmods/mobile.php") {
        do {
            let contents = try! NSString(contentsOfURL: url, usedEncoding: nil)
            let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            do {
<<<<<<< HEAD
                let contents = try! NSString(contentsOfURL: url, usedEncoding: nil)
                print("tried contents");
                
                let requestURL: NSURL = url
                let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(urlRequest) {
                    (data, response, error) -> Void in
                    
                    if error == nil {
                        print(data);
                        print("Success!");
                    } else {
                        print("Fail")
                    }
                }
                
                task.resume()
                
                
                
                let data = contents.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)!
                print("encoded contents");
                do {
                    let todaysDate:NSDate = NSDate()
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
                    //the hour format
                    let hourFormatter:NSDateFormatter = NSDateFormatter()
                    hourFormatter.dateFormat = "H"
                    let DateInHourFormat:String = hourFormatter.stringFromDate(todaysDate)
                    //the month format
                    let monthFormatter:NSDateFormatter = NSDateFormatter()
                    monthFormatter.dateFormat = "MMMM"
                    let DateInMonthFormat:String = monthFormatter.stringFromDate(todaysDate)
                    //the num day format
                    let dayFormatter:NSDateFormatter = NSDateFormatter()
                    dayFormatter.dateFormat = "dd"
                    let DateInNumDayFormat:String = dayFormatter.stringFromDate(todaysDate)
                    //the weekday format
                    let weekdayFormatter:NSDateFormatter = NSDateFormatter()
                    weekdayFormatter.dateFormat = "EEEE"
                    //the minute format
                    let minuteFormatter:NSDateFormatter = NSDateFormatter()
                    minuteFormatter.dateFormat = "m"
                    let DateInMinuteFormat:String = minuteFormatter.stringFromDate(todaysDate)
                    //create current time as a weird number for the morning meeting code
                    let timeAsaString = DateInHourFormat + "." + DateInMinuteFormat;
                    let timeAsaNumber = Float(timeAsaString);
                    var error:NSError? = nil
                    print(error);
                    
                    if DateInDayFormat == "Sat" || DateInDayFormat == "Sun" {
                        //display weekend labels
                        letter_day_label.setText("It's")
                        next_mod_label.setText("The")
                        mod_time_label.setText("Weekend")
                        
                    } else {
                        if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) {
                            if let dict = jsonObject as? NSDictionary {
                                print(dict)
                                let cyc = dict["cycleval"] as! String
                                let mod = dict["mod"] as! String
                                let mod_time = dict["modstart"] as? String
                                print(DateInDayFormat)
                                print(cyc)
                                print(mod)
                                print(mod_time)
                                if mod == "no school" {
                                    next_mod_label.setText("School")
                                    letter_day_label.setText("No")
                                    mod_time_label.setText("Today!")
                                    
                                }
                                else {
                                    if DateInDayFormat == "Wed" && timeAsaNumber <= 8.45 {
                                        //morning meeting begins at 8:45
                                        letter_day_label.setText("Morning")
                                        next_mod_label.setText("Meeting")
                                        mod_time_label.setText("8:45")                                    }
                                    else {
                                        if timeAsaNumber <= 8.00 && DateInDayFormat != "Wed" && DateInDayFormat != "Sat" && DateInDayFormat != "Sun"{
                                            //morning meeting begins at 8:00
                                            letter_day_label.setText("Morning")
                                            next_mod_label.setText("Meeting")
                                            mod_time_label.setText("8:00")
                                        } else {
                                            if mod == "over" {
                                                //this is after school
                                                next_mod_label.setText("is")
                                                letter_day_label.setText("School")
                                                mod_time_label.setText("Out!")
                                            } else {
                                                if mod == "19"{
                                                    //this is before 3:10 but after mod 18 has begun
                                                    letter_day_label.setText("Day")
                                                    next_mod_label.setText("ends at")
                                                    mod_time_label.setText("3:10")
                                                    
                                                } else {
                                                    if mod == "finals" {
                                                        next_mod_label.setText("Luck")
                                                        letter_day_label.setText("Good")
                                                        mod_time_label.setText("Today!")
                                                    } else {
                                                        let cycstr = cyc + "";
                                                        letter_day_label.setText(cycstr);
                                                        let modstr = mod
                                                            + "";
                                                        next_mod_label.setText(modstr);
                                                        let timestr = mod_time! + "";
                                                        mod_time_label.setText(timestr);
                                                        
                                                    }
                                                }
                                            }
=======
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
                        print(mod);
                        print(cyc);
                        print(mod_time);
                        
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
>>>>>>> parent of 23a5cf2... stuff!
                                        }
                                    }
                                }
                            }
<<<<<<< HEAD
                        } else {
                            print("not a dictionary")
                            next_mod_label.setText("Dict")
                            letter_day_label.setText("Oops")
                            mod_time_label.setText("Oops")
                        }
=======
                        }
                    }else {
                        print("not a dictionary")
>>>>>>> parent of 23a5cf2... stuff!
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
        loadweb();
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
