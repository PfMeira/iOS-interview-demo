//
//  UserCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 18/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    func configurateCell(authorName: String, email: String) {
        self.authorName.text = authorName
        self.email.text = email
    }
}
