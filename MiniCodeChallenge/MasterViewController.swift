//
//  MasterViewController.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import UIKit

//Used to denote the currently selected segment
enum SortOrder
{
    case ByName, ByArrival
}

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //MARK: - Outlets
    @IBOutlet weak var noNetworkLabel: UILabel!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - vars
    var locations = [Location]()
    var currentSortOrder:SortOrder = .ByName
    
    //MARK: - Controller LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.fetchData()
    }
    
    //MARK: - TableView Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
        let date = locations[indexPath.row].arrivalTime
        cell.textLabel?.text = locations[indexPath.row].name
        cell.detailTextLabel?.text = Location.stringFromDate(date)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        performSegueWithIdentifier("DetailsSegue", sender: indexPath.row)
    }
   
    //MARK: - Segue Logic
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let id = segue.identifier
        {
            switch(id)
            {
            case "DetailsSegue":
                    if let detailsController = segue.destinationViewController as? DetailViewController
                    {
                        if let index = sender as? Int
                        {
                            detailsController.location = self.locations[index]
                        }
                    }
            default:
                break
            }
        }
    }
    
    //MARK: - Data
    func fetchData()
    {
        //if connected to network make network request
        if(Reachability.isConnectedToNetwork())
        {
            noNetworkLabel.hidden = true
            activityIndicator.startAnimating()
            
            //make network request in background
            LocationNetworkSingleton.sharedInstance.getLocationsInBackground()
                {
                    [unowned self]
                    (locationObjects:[Location], error:NSError?) in
                    
                    guard locationObjects.count > 0 else
                    {
                        return
                    }
                    
                    //sort location by currently selected segment
                    self.locations = self.sortLocations(sortOrder: self.currentSortOrder, locationArray: locationObjects)
                    
                    //update tableView on main queue
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            [unowned self]
                            () -> Void in
                            self.tableView.reloadData()
                            self.activityIndicator.stopAnimating()
                        })
                }
        }
            
        //display no network header if no network is available
        else
        {
            noNetworkLabel.hidden = false
        }
    }
    
    @IBAction func refreshData(sender: UIBarButtonItem)
    {
        self.fetchData()
    }

    //MARK: - Segments
    
    //Sorts location array based on segment enum passed in
    func sortLocations(sortOrder sortOrder:SortOrder, locationArray:[Location]) -> [Location]
    {
        switch(sortOrder)
        {
        case .ByName:
            return locationArray.sort{ (location1, location2) -> Bool in location1.name < location2.name }
        case .ByArrival:
            return locationArray.sort{ (location1, location2) -> Bool in location1.arrivalTime.compare(location2.arrivalTime) == .OrderedAscending}
        }
    }
    
    //Handles changing section segments
    @IBAction func didchangeSegment(segmentedControl:UISegmentedControl)
    {
        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            self.locations = sortLocations(sortOrder: .ByName, locationArray: self.locations)
            self.currentSortOrder = .ByName
        case 1:
            self.locations = sortLocations(sortOrder: .ByArrival, locationArray: self.locations)
            self.currentSortOrder = .ByArrival
        default:
            break
        }
        tableView.reloadData()
    }
}

