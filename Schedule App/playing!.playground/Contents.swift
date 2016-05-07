//: Playground - noun: a place where people can play

import UIKit

NSURL * url = [NSURL URLWithString:@"https://api.github.com/users/mralexgray/repos"];

NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
NSLog(@"data size %ld", (unsigned long)data.length);
}];

[downloadTask resume];