//
//  LocationAnnotation.swift
//  MiniCodeChallenge
//
//  Created by Sumit Punjabi on 1/5/16.
//  Copyright © 2016 wakeupsumo. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation
{
    let title:String?
    let subtitle:String?
    let coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D)
    {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}