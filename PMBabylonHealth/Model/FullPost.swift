//
//  PostAllInformaticions.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 20/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import Foundation

//struct PostAllInformaticions {
//    let authorName: String
//    let emailAuthor: String
//    let numberOfComments: Int
//    let latitude: String
//    let longitude: String
//}

struct FullPost {
    let author: Author
    let numberOfComments: Int
    let address: Address
}

struct Author {
    let authorName: String
    let emailAuthor: String
}

struct Address {
    let latitude: String
    let longitude: String
}

let address = Address(latitude: "123", longitude: "456")
let author = Author(authorName: "zé", emailAuthor: "zé@gmail.com")
let fullPost = FullPost(author: author, numberOfComments: 10, address: address)

