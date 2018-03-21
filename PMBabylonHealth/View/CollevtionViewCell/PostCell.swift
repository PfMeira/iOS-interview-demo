//
//  PostCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 17/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    func configurateCell(title: String, identifier: Int) {
        
        titleLabel.text = title
        idLabel.text = "\(identifier)"
    }
}
