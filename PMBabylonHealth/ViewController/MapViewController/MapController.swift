//
//  MapController.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 17/04/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MapView!
    var fullPost: PostsInformations?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.configure(fullPost: fullPost)
    }
    
}
