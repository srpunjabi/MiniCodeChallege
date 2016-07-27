//
//  LocationNetworkClientTests.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import XCTest
@testable import MiniCodeChallenge

class LocationNetworkClientTests: XCTestCase {
    
    var testNetworkClient:LocationNetworkSingleton!
    var completionHandlerCalled:Bool = false
 
    override func setUp()
    {
        super.setUp()
        testNetworkClient = LocationNetworkSingleton.sharedInstance
    }
    
    override func tearDown()
    {
        testNetworkClient = nil
        super.tearDown()
    }
    
    //MARK: - Tests
    
    //test LocationNetworkClient Singleton
    func testLocationClientSingleton()
    {
        testNetworkClient = nil
        testNetworkClient = LocationNetworkSingleton.sharedInstance
        XCTAssertNotNil(testNetworkClient, "Singleton should return static LocationNetworkClient instance")
    }
    
    //MARK: - Error
    func testIfErrorOccurs()
    {
        testNetworkClient.BASE_URL = ""
        testNetworkClient.getLocations(fakeCompletionHandler)
        XCTAssertFalse(self.completionHandlerCalled, "Completion handler shouldn't be called if an error occurs")
    }
    
    //MARK: - JSON
    //test what happens if broken json is sent for parsing
    func testBrokenJSON()
    {
        let brokenJsonData = "{".dataUsingEncoding(NSUTF8StringEncoding)
        
        testNetworkClient.parseJSONWithCompletionHandler(brokenJsonData!, completionHandler:fakeCompletionHandler)
        
        XCTAssertFalse(self.completionHandlerCalled, "Completion block shouldn't be called when JSON is invalid")
    }
    
    //test what happens if valid json is sent for parsing
    func testValidJSON()
    {
        let validJSON = "[ { \"ID\": 1909,\"Name\" : \"Doughnut Vault Canal\", \"Latitude\" : 41.883976, \"Longitude\" : -87.639346, \"Address\": \"11 N Canal St L30 Chicago, IL 60606\", \"ArrivalTime\" : \"2016-01-06T02:07:00.667\" } ]".dataUsingEncoding(NSUTF8StringEncoding)
        testNetworkClient.parseJSONWithCompletionHandler(validJSON!, completionHandler: fakeCompletionHandler)
        XCTAssertTrue(self.completionHandlerCalled, "Completion handler should be called when the JSON data is valid")
    }
    
    //MARK: - Fake Completion Handler
    func fakeCompletionHandler(result:[Location], error:NSError?)
    {
        if(result.count > 0)
        {
            self.completionHandlerCalled = true
        }
        else
        {
            self.completionHandlerCalled = false
        }
    }
}
