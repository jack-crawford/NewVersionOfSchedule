//: Playground - noun: a place where people can play

import Foundation
func login() {
    let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/Teer/teer-dev/mobilelogin.php")!)
    request.HTTPMethod = "POST"
    let username = "jack@email.com";
    let password = "password";
    var postString = "username="
    postString += username
    postString += "&password="
    postString += password
    print(postString);
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    print(request.HTTPBody);
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in guard error == nil && data != nil
        else {
            // check for fundamental networking error
            print("error=\(error)")
            return
        }
        
        if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
            // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
        }
        
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        print("responseString = \(responseString)");
        
    }
    task.resume()
}
login()