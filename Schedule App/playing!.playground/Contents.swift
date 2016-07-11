//: Playground - noun: a place where people can play

import UIKit


let todaysDate:NSDate = NSDate()
let dateFormatter:NSDateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "EEE"
print(dateFormatter)
let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
print(DateInDayFormat)


let urlPath: String = "http://hollandhall.net/hhmods/mobile.php"
let url: NSURL = NSURL(string: urlPath)!
let request1: NSURLRequest = NSURLRequest(URL: url)
let queue:NSOperationQueue = NSOperationQueue()

NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
    
    do {
        if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
            print("ASynchronous\(jsonResult)")
            
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
    
    
})