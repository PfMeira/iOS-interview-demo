//
//  PostsInformations.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 16/05/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class PostsInformations: Object {
    
//    @objc dynamic var id = UUID().uuidString
    @objc dynamic var userID: Int = 0
    @objc dynamic var author: Author? = nil
    @objc dynamic var numberOfComments: Int = 0
    @objc dynamic var address: Address? = nil

    convenience init(userIdentifier: Int, authorData: Author, numberComments: Int, addressData: Address) {
        self.init()
        self.userID = userIdentifier
        self.author = authorData
        self.numberOfComments = numberComments
        self.address = addressData
    }
    override static func primaryKey() -> String? {
        return "userID"
    }
    
    @discardableResult static func createPost(in realm: Realm, nPost: Array<Any>) -> PostsInformations {
        return PostsInformations()
    }
}

class Author: Object {
    @objc dynamic var authorName: String = ""
    @objc dynamic var authorEmail: String = ""
    
    convenience init(nameAuthor: String, emailAuthor: String) {
        self.init()
        self.authorName = nameAuthor
        self.authorEmail = emailAuthor
    }
}

class Address: Object {
    
    @objc dynamic var latitude: Double = 0.00
    @objc dynamic var longitude: Double = 0.00
    @objc dynamic var city: String = ""
    @objc dynamic var street: String = ""
    
    convenience init(lat: Double, long: Double, cityAddress: String, streetAddress: String) {
        self.init()
        self.latitude = lat
        self.longitude = long
        self.city = cityAddress
        self.street = streetAddress
    }
}
