//
//  MapTableViewCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 15/04/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: MapView!
    
    func configure(fullPost: PostsInformations?) {
        viewCell.configure(fullPost: fullPost)
    }
}
