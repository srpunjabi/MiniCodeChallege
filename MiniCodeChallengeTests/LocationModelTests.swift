//
//  LocationModeTest.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import XCTest
@testable import MiniCodeChallenge

class LocationModelTests: XCTestCase {

    let jsonDictionary:[String : AnyObject] =
    ["ID" : 1909,
        "Name" : "Doughnut Vault Canal",
        "Latitude" : 41.883976,
        "Longitude" : -87.639346,
        "Address" : "11 N Canal St L30 Chicago, IL 60606",
        "ArrivalTime": "2016-01-06T02:07:00.667"
    ]
    
    var locationObject:Location?

    override func setUp()
    {
        super.setUp()
        locationObject = Location(dict: jsonDictionary)
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testEmptyDictionary()
    {
        XCTAssertNil(Location(dict: [:]), "No object should be returned if an empty dictionary is sent to Location Model")
    }
    
    func testValidDictionary()
    {
        XCTAssertNotNil(locationObject, "A valid Location object should be returned")
    }
    
    func testID()
    {
        XCTAssertEqual(locationObject?.ID, jsonDictionary["ID"] as? Int, "locationObject was assigned proper ID based on json data")
    }
    
    func testName()
    {
        XCTAssertEqual(locationObject?.name, jsonDictionary["Name"] as? String, "locationObject was assigned proper Name based on json data")
    }
    
    func testLatitude()
    {
        XCTAssertEqual(locationObject?.latitude, jsonDictionary["Latitude"] as? Double, "locationObject was assigned proper Latitude based on json data")
    }
    
    func testLongitude()
    {
        XCTAssertEqual(locationObject?.longitude, jsonDictionary["Longitude"] as? Double, "locationObject was assigned proper Longitude based on json data")
    }
    
    func testAddress()
    {
        XCTAssertEqual(locationObject?.address, jsonDictionary["Address"] as? String, "locationObject was assigned proper Address based on json data")
    }
    
    func testDate()
    {
        let dateString = jsonDictionary["ArrivalTime"] as? String
        let jsonDate = Location.dateFromTimeStamp(dateString!)
        XCTAssertEqual(locationObject?.arrivalTime, jsonDate, "locationObject was assigned proper Date based on json data")
    }
}
