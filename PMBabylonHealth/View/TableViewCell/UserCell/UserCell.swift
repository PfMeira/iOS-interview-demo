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
        guard let authorLabel = self.authorName.text else { return }
        guard let emailLabel = self.email.text else { return }
        self.authorName.text = "\(authorLabel) \(authorName)"
        self.email.text  = "\(emailLabel) \(email)"
    }
}
