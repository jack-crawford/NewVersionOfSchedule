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
        self.timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "loadweb", userInfo: nil, repeats: true)
        
        
    }
    func loadweb(){
        print("started loadweb")
        if let url = NSURL(string: "http://hollandhall.net/hhmods/mobile.php") {
            do {
                //let contents = try! NSString(contentsOfURL: url, usedEncoding: nil)
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
                
                
                
                let contents = ""
                
                let data = contents.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)!
                print("encoded contents");
                do {
                    let todaysDate:NSDate = NSDate()
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
                    
                    var error:NSError? = nil
                    print(error);
                    if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) {
                        print("tried JSON");
                        if let dict = jsonObject as? NSDictionary {
                            print("turned json into NSDict");
                            print(dict)
                            let cyc = dict["cycleval"] as? String
                            let mod = dict["mod"] as? String
                            let mod_time = dict["modstart"] as? String
                            //print(cyc)
                            //print(mod)
                            //print(mod_time)
                            if mod == "19" {
                                letter_day_label.setText("Day")
                                next_mod_label.setText("ends at")
                                mod_time_label.setText("3:10")
                                //print("mod 19");
                            } else {
                                if mod == "good morning" {
                                    next_mod_label.setText("Morning")
                                    letter_day_label.setText("Good")
                                    mod_time_label.setText("Dutch")
                                    //print("good morning");
                                } else {
                                    if DateInDayFormat == "Sat" || DateInDayFormat == "Sun" {
                                        //happy weekend message
                                        //print("today's a saturday")
                                    } else {
                                        if mod == "over"{
                                            next_mod_label.setText("is")
                                            letter_day_label.setText("School")
                                            mod_time_label.setText("Out!")
                                            print("over")
                                        } else {
                                            if mod == "no school" {
                                                next_mod_label.setText("School")
                                                letter_day_label.setText("No")
                                                mod_time_label.setText("Today!")
                                                //print("no school")
                                            } else {
                                                //print("school day");
                                                let cycstr = cyc! + "";
                                                letter_day_label.setText(cycstr);
                                                
                                                let modstr = mod! + "";
                                                next_mod_label.setText(modstr);
                                                let timestr = mod_time! + "";
                                                mod_time_label.setText(timestr);
                                            }
                                        }
                                    }
                                }
                            }
                        }else {
                            print("not a dictionary")
                            next_mod_label.setText("Oops")
                            letter_day_label.setText("Oops")
                            mod_time_label.setText("Oops")
                            
                        }
                    } else {
                        print("Could not parse JSON: \(error!)")
                        next_mod_label.setText("Oops")
                        letter_day_label.setText("Oops")
                        mod_time_label.setText("Oops")
                        
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    next_mod_label.setText("Oops")
                    letter_day_label.setText("Oops")
                    mod_time_label.setText("Oops")
                    
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
