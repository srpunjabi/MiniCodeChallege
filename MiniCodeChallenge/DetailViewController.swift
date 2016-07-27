//
//  DetailViewController.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var coordinates: UILabel!
    
    //MARK: - variables
    var location:Location?
    
    //MARK: - Controller Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let location = location
        {
            let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            centerMapOnLocation(initialLocation)
            showPin(location)
            setupOutlets(location)
        }
    }
    
    //MARK: - Helpers
    
    //sets up labels on viewDidLoad
    func setupOutlets(location:Location)
    {
        name.text = location.name
        address.text = location.address
        coordinates.text = "lat:  \(location.latitude)     long:  \(location.longitude)"
        
        let dateString = Location.stringFromDate(location.arrivalTime)
        arrivalTime.text = "Arrival Time: \(dateString)"
    }
    
    //centers map to given coordinates on screen
    func centerMapOnLocation(location: CLLocation)
    {
        let regionRadius: CLLocationDistance = 20
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //shows pin on the map with annotation
    func showPin(location:Location)
    {
        let coord = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let annotation = LocationAnnotation(title: location.name, subtitle: location.address, coordinate: coord)
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }
}

extension DetailViewController: MKMapViewDelegate
{
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation =  annotation as? LocationAnnotation
        {
            let reuseId = "pin"
            var view:MKPinAnnotationView
            
            if let dequedView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            {
                view = dequedView
                view.annotation = annotation
            }
            else
            {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view.canShowCallout = true
            }
            return view
        }
        return nil
    }
}
