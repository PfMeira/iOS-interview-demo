//
//  CommentsCell.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 18/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    func configurateCell(fullPost: PostsInformations? ) {
        print("CommentsCell")
        guard let number = fullPost?.numberOfComments else { return }
        self.commentsLabel.text = String(number)
    }
}
