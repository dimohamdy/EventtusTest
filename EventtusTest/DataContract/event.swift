//
//  event.swift
//  EventtusTest
//
//  Created by binaryboy on 2/16/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//


import UIKit
import Foundation

class Event{

    var name:String
    var image:String
    var coverImage:String
    var  startDate:NSDate
    var  endDate:NSDate
    
    
   init (dic: NSDictionary) {
        self.name = dic.valueForKey("name") as NSString
        self.image = dic.valueForKey("image") as NSString
        self.coverImage = dic.valueForKey("coverImage") as NSString

    var dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")

    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"


        self.startDate =  dateFormatter.dateFromString(dic.valueForKey("startDate") as NSString)!
        self.endDate = dateFormatter.dateFromString(dic.valueForKey("endDate") as NSString)!

    
    }
}