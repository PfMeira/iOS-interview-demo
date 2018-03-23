//
//  MapViewCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 18/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import MapKit

class MapViewCell: UITableViewCell {
    
    let locationManager = CLLocationManager()
    var pointAnnotation: MKPointAnnotation!
    
    //@IBOutlet weak var mapView: MKMapView!
    
    func configure() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MapViewCell: MKMapViewDelegate {
    
}

extension MapViewCell: CLLocationManagerDelegate {
    
}
