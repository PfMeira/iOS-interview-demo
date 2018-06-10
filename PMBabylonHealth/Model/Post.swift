//
//  Post.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 20/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import RealmSwift

class Post: Object {
    
    @objc dynamic var userId: Int = 0
    @objc dynamic var identifierPost: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    convenience init(idUser: Int, identifierPost: Int, titlePost: String,  msgBody: String) {
        self.init()
        self.identifierPost = identifierPost
        self.userId = idUser
        self.title = titlePost
        self.body = msgBody
    }
    
    override static func primaryKey () -> String? {
        return "identifierPost"
    }
    
    @discardableResult static func createPost(in realm: Realm, nPost: Array<Any>) -> Post {
        return Post()
    }
}
