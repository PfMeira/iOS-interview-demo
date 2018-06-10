//
//  MapView.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 15/04/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewFromNib {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    func configure(fullPost: PostsInformations?) {
        
        guard let latitude = fullPost?.address?.latitude, let longitude = fullPost?.address?.longitude else { return }
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let coordinateRegion = MKCoordinateRegion(center: locationCoordinate, span: span)
        mapView.setRegion(coordinateRegion, animated: true)
        
        guard let titleCity = fullPost?.address?.city, let subtitleStreet = fullPost?.address?.street else { return }
        let pointAnnotations = MKPointAnnotation()
        pointAnnotations.coordinate.latitude = latitude
        pointAnnotations.coordinate.longitude = longitude
        pointAnnotations.title = titleCity
        pointAnnotations.subtitle = subtitleStreet
        mapView.addAnnotation(pointAnnotations)
    }
}

extension MapView: MKMapViewDelegate {
}

class UIViewFromNib: UIView {
    
    var contentView: UIView!
    var nibName: String {
        return String(describing: type(of: self)) }
    
    // MARK
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    //MARK:
    func loadViewFromNib() {
        contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
}
