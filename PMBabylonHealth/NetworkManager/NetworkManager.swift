//
//  NetworkManager.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 19/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    static let sharedNetworkManager = NetworkManager()
    
    private override init() {
    }
    
    typealias GetPosts = (Result <[[String: Any]]>) -> Void
    typealias GetUsers = (Result <[String: Any]>) -> Void
    typealias GetComments = (Result <Int>) -> Void
    
    func getPostInformations(completed: @escaping GetPosts) {
        Alamofire.request("https://jsonplaceholder.typicode.com/posts", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            let responseResult = response.result
            switch responseResult {
            case .success (let posts):
                guard let postsDetails = posts as? [[String: Any]] else {
                    let error = NSError()
                    completed(.failure(error))
                    return
                }
                completed(.success(postsDetails))
                
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    func getUsersInformations(userIdentifier: Int, completed: @escaping GetUsers) {
        Alamofire.request("https://jsonplaceholder.typicode.com/users", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            let responseResult = response.result
            switch responseResult {
            case .success (let posts):
                guard let postsDetails = posts as? [[String: Any]] else {
                    let error = NSError()
                    completed(.failure(error))
                    return
                }
                var userDetail: [String: Any] = [:]
                for i in 0 ..< postsDetails.count {
                    let user = postsDetails[i]
                    guard let idUser = user["id"] as? Int else { return }
                    if userIdentifier == idUser {
                        userDetail = postsDetails[i]
                        break
                    }
                }
                completed(.success(userDetail))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getCommentsInformations(userIdentifier: Int, completed: @escaping GetComments) {
        Alamofire.request("https://jsonplaceholder.typicode.com/comments", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            let responseResult = response.result
            switch responseResult {
            case .success (let comments):
                guard let commentsDetails = comments as? [[String: Any]] else {
                    let error = NSError()
                    completed(.failure(error))
                    return
                }
                var sumPost = 0
                for increment in 0 ..< commentsDetails.count {
                    let commentDetail = commentsDetails[increment] 
                    print(increment)
                    guard let userId = commentDetail["postId"] as? Int else { return }
                    if userId == userIdentifier {
                        sumPost += 1
                    }
                }
                completed(.success(sumPost))
                
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
}
