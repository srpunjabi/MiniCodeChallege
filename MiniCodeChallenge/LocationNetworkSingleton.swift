//
//  LocationNetworkSingleton.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import Foundation

class LocationNetworkSingleton : NSObject
{
    var BASE_URL = "http://localsearch.azurewebsites.net/api/Locations"
    var session:NSURLSession
    static let sharedInstance = LocationNetworkSingleton()

    private override init()
    {
        self.session = NSURLSession.sharedSession()
        super.init()
    }
    
    //Makes network request in background
    func getLocationsInBackground(completionHandler: (result:[Location], error:NSError?) -> Void)
    {
        //make network request in background
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))
        {
            [unowned self] () in
            self.getLocations(completionHandler)
        }
    }
    
    //Makes network request to azure server
    func getLocations(completionHandler: (result: [Location], error:NSError?) -> Void)
    {
        let urlstring = BASE_URL
        let url = NSURL(string: urlstring)!
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request, completionHandler:
            {
                (data, response, error) in
                
                /* Check for error */
                guard(error == nil) else
                {
                    print("request failed with error: \(error)")
                    return
                }
                
                /* Check response code must be between 200 and 299 */
                guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else
                {
                    print("request returned an invalid response from the server")
                    return
                }
                
                /* Check if any data was returned */
                guard let data = data else
                {
                    print("No data was returned upon request")
                    return
                }
                
                /* Parse JSON Data */
                self.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            })
        task.resume()
    }
    
    func parseJSONWithCompletionHandler(data:NSData, completionHandler: (result: [Location], error:NSError?) -> Void)
    {
        let parsedResults: AnyObject?
        var locations = [Location]()
        
        do
        {
            parsedResults = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        }
        catch let error as NSError?
        {
            parsedResults = nil
            completionHandler(result: locations, error:error)
            return
        }
        
        guard let locationsArray = parsedResults as? [[String : AnyObject]] else
        {
            completionHandler(result: locations, error:nil)
            return
        }
        
        /* Create an array of Location objects */
        for jsonDictionary in locationsArray
        {
            let location = Location(dict: jsonDictionary)
            guard let validLocation = location else
            {
                print("Invalid JSON dictionary")
                return
            }
            locations.append(validLocation)
        }
        completionHandler(result: locations,error: nil)
    }
}