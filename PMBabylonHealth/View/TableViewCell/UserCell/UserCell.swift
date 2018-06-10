//
//  UserCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 18/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

protocol NibDescriptor {
    static var nibName: String { get }
}

class UserCell: UITableViewCell {
        
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    static let defaultHeight: Int = {
        return 64
    }()
    
    func configurateCell(user: Author?) {
        guard let author = user?.authorName, let email = user?.authorEmail else { return }

        self.authorName.text = author
        self.email.text = email
    }
}

extension UserCell: CellDescriptor {
    static var nibName: String {
        return String(describing: self)
    }
}

