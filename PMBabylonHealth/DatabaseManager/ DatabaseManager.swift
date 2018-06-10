//
//  DatabaseManager.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 03/05/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let sharedDatabaseManager = DataManager()
    
    var realm = try! Realm()
    
    private init() {
        print(realm.configuration.fileURL)
    }
    
    func getAllPosts() -> Results <Post> {
        let posts = realm.objects(Post.self)
        return posts
    }

    func removePost(post: Post) {
        try! realm.write {
            realm.delete(post)
        }
    }
    
    func removeAllPosts() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func addPost(post: Post) {
        try! realm.write {
            realm.create(Post.self, value: post, update: true)
        }
    }
    
    // *********************************************//
    
    
    //TODO 2 Não sei se faz sentido esta logica
    // Rever
    func getAllPostsInformations() -> Results <PostsInformations> {
        let postsInformations = realm.objects(PostsInformations.self)
        return postsInformations
    }
    
    
    func getPost(userID: Int ) -> Results<PostsInformations> {
        print(userID)
        let workouts = realm.objects(PostsInformations.self).filter("userID = %@", userID)
        print(workouts)
        
//        guard let postInformations = realm.object(ofType: PostsInformations.self, forPrimaryKey: userID) else {
//
//            return PostsInformations()
//        }
        return workouts
    }
    
    func getPostInformation(postInformations: PostsInformations){
        try! realm.write {
            realm.create(PostsInformations.self, value: postInformations, update: true)
        }
    }
}
