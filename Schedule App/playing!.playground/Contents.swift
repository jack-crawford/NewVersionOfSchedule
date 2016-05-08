//: Playground - noun: a place where people can play

import UIKit


let todaysDate:NSDate = NSDate()
let dateFormatter:NSDateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "EEE"
print(dateFormatter)
let DateInDayFormat:String = dateFormatter.stringFromDate(todaysDate)
print(DateInDayFormat)