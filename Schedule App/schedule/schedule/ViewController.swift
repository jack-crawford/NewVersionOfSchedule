//
//  ViewController.swift
//  schedule
//
//  Created by Jack Crawford on 2/12/16.
//  Copyright © 2016 Jack Crawford. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var today_label: UILabel!
    @IBOutlet weak var at_label: UILabel!
    @IBOutlet weak var letter_display: UILabel!
    @IBOutlet weak var next_mod_time_label: UILabel!
    @IBOutlet weak var message_label: UILabel!
    @IBOutlet weak var mod_display: UILabel!

    let schoolred = UIColor(red:0.77, green:0.08, blue:0.11, alpha:1.0)
    let schoolblue = UIColor(red:0.54, green:0.73, blue:0.87, alpha:1.0)
    var timer = NSTimer()

    
    
    @IBAction func menubutton(sender: AnyObject) {
        if today_label.textColor == UIColor.blackColor() {
            today_label.textColor = schoolred;
            at_label.textColor = UIColor.whiteColor();
            letter_display.textColor = schoolred;
            next_mod_time_label.textColor = UIColor.whiteColor();
            mod_display.textColor = schoolblue;
            message_label.textColor = schoolblue;
            self.view.backgroundColor = UIColor.blackColor()
        } else {
            today_label.textColor = UIColor.blackColor();
            at_label.textColor = UIColor.blackColor();
            letter_display.textColor = UIColor.blackColor();
            next_mod_time_label.textColor = UIColor.blackColor();
            mod_display.textColor = UIColor.blackColor();
            message_label.textColor = UIColor.blackColor();
            self.view.backgroundColor = UIColor.whiteColor()
        }
        print("button")
        loadweb()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadweb()
                timer = NSTimer.scheduledTimerWithTimeInterval(90, target: self, selector: "loadweb", userInfo: nil, repeats: true)
    }
    func loadmessage(string: String) -> String {
        if let url = NSURL(string: "http://localhost:8888/Schedule-Project/message.php") {
            do {
                let contents = try NSString(contentsOfURL: url, usedEncoding: nil)
                return contents as String
            } catch {
                // contents could not be loaded
                return ""
            }
        } else {
            // the URL was bad!
            return ""
        }
    }
    func loadweb(){
        print("loadweb started")
        if let url = NSURL(string: "http://localhost:8888/Schedule-Project/mobile.php") {
            do {
                let contents = try! NSString(contentsOfURL: url, usedEncoding: nil)
                let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                do {
                    let todaysDate:NSDate = NSDate()
                    let dateFormatter:NSDateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    let hourFormatter:NSDateFormatter = NSDateFormatter()
                    hourFormatter.dateFormat = "HH"
                    let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
                    let DateInHourFormat:String = hourFormatter.stringFromDate(todaysDate)
                    let error:NSError? = nil
                    print(DateInDayFormat)
                    print(DateInHourFormat)
                    if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) {
                        if let dict = jsonObject as? NSDictionary {
                            print(dict)
                            let cyc = dict["cycleval"] as! String
                            let mod = dict["mod"] as! String
                            let mod_time = dict["modstart"] as? String
                            print(DateInDayFormat)
                            let message = loadmessage("test")
                            
                            if DateInDayFormat == "Sat" || DateInDayFormat == "Sun" {
                                //display weekend labels
                                letter_display.text = cyc + "day";
                                mod_display.text = "the weekend"
                                next_mod_time_label.text = "Monday"
                                at_label.text = "Will be"
                                message_label.text = ""
                                today_label.text = "it's"
                            } else {
                                if mod == "good morning" {
                                    letter_display.text = "Good";
                                    mod_display.text = "Morning!"
                                    next_mod_time_label.text = ""
                                    at_label.text = ""
                                    today_label.text = ""
                                } else {
                                    if mod == "no school" {
                                        letter_display.text = "School";
                                        mod_display.text = "is Out"
                                        next_mod_time_label.text = ""
                                        at_label.text = ""
                                        today_label.text = ""
                                        message_label.text = message
                                        print("over")
                                    } else {
                                        if mod == "over" {
                                            letter_display.text = "School";
                                            mod_display.text = "is Out"
                                            next_mod_time_label.text = ""
                                            at_label.text = ""
                                            today_label.text = ""
                                            message_label.text = message
                                            print("over")
                                        } else {
                                            if mod == "19"{
                                                mod_display.text = "School ends"
                                                next_mod_time_label.text = "3:10"
                                                at_label.text = "at"
                                                letter_display.text = cyc + " Day";
                                                message_label.text = message;
                                                today_label.text = "Today Is"
                                            } else {
                                                letter_display.text = cyc + " Day";
                                                message_label.text = message;
                                                mod_display.text = "Mod " + mod;
                                                next_mod_time_label.text = mod_time;
                                                today_label.text = "Today Is"
                                                at_label.text = "begins at"
                                            }
                                        }
                                    }
                                }
                            }
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
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}