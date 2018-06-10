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
    @IBOutlet weak var viewPostCell: UIView!
    
    func configurateCell(title: String, identifier: Int) {
        
        titleLabel.text = title
        idLabel.text = "\(identifier)"
        
        // MARK: - Rounded corners
        let maskLayer = CAShapeLayer()
        maskLayer.frame = viewPostCell.bounds
        maskLayer.path = UIBezierPath(roundedRect: viewPostCell.bounds, byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 6, height: 6)).cgPath
        viewPostCell.layer.mask = maskLayer
    }
}
