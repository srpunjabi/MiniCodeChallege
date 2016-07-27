//
//  Location.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import UIKit

class Location
{
    var ID:Int = -1
    var name:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var address:String = ""
    var arrivalTime:NSDate = NSDate()
    
    init?(dict:[String : AnyObject])
    {
        guard let id = dict[LocationKeys.ID] as? Int
            else { return nil }
        guard let name = dict[LocationKeys.NAME] as? String where name.characters.count > 0
            else { return nil }
        guard let latitude = dict[LocationKeys.LATITUDE] as? Double
            else { return nil }
        guard let longitude = dict[LocationKeys.LONGITUDE] as? Double
            else { return nil }
        guard let address = dict[LocationKeys.ADDRESS] as? String
            else { return nil }
        guard let dateString = dict[LocationKeys.ARRIVALTIME] as? String
            else { return nil }
        guard let arrivalTime = Location.dateFromTimeStamp(dateString)
            else { return nil }
        
        self.ID = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.arrivalTime = arrivalTime
    }
    
    //MARK: - Helpers
    static func dateFromTimeStamp(dateString:String) -> NSDate?
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.dateFromString(dateString)!
        return date
    }
    
    static func stringFromDate(date:NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(date)
    }
}