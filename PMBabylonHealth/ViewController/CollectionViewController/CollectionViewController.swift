//
//  CollectionViewController.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 17/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nib = UINib(nibName: "PostCell", bundle: nil)
            collectionView?.register(nib, forCellWithReuseIdentifier: "postCell")
        }
    }
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    
    fileprivate let itemPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    
    var post: [Post] = []
    let databaseManager = DatabaseProviderRepresentable.sharedDatabaseManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedNetworkManager.delegateReachability = self
        getPosts()
    }
    
    func getPosts() {
        
        stateActivityIndicator (state: false)
        NetworkManager.sharedNetworkManager.getPostInformations(completed: { result in
            
            switch result {
            case .success(let allPosts):
                for positionsPost in 0 ..< allPosts.count {
                    let post = allPosts[positionsPost]
                    guard let userId = post["userId"] as? Int, let identifierPost = post["id"] as? Int, let title = post["title"] as? String, let body = post["body"] as? String else { return }
                    let newPost = Post.init(idUser: userId, identifierPost: identifierPost, titlePost: title, msgBody: body)
                    self.post.append(newPost)
                    self.databaseManager.addPost(post: newPost)
                }
                self.collectionView.reloadData()
                
                self.stateActivityIndicator (state: true)
            case .failure(_):
                if self.databaseManager.getAllPosts().count != 0 {
                    for post in self.databaseManager.getAllPosts() {
                        self.post.append(post)
                    }
                    self.collectionView.reloadData()
                    self.stateActivityIndicator (state: true)
                }
                else {
                    self.changeTextStatus(status: "Internet connection error")
                }
            }
        })
    }
    
    func stateActivityIndicator (state: Bool) {
        //TODO FIX ME: - simplificar! usar truques fixes
        //Era isto ??
        let result = state ? true : false
        activityIndicatorView.isHidden = result
        if result {
            activityIndicator.stopAnimating()

        } else {
            activityIndicator.startAnimating()
        }
    }
    
    func changeTextStatus(status: String) {
        connectionStatusLabel.text = "Internet connection error"
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetail = post[indexPath.row]
        let detailsTableViewController = DetailsTableViewController()
        detailsTableViewController.identifierUser = postDetail.userId
        
        self.navigationController?.pushViewController(detailsTableViewController, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as?  PostCell else {
            return UICollectionViewCell()
        }
        // verificar que indexpath menor postModel count
        let postDetail = post[indexPath.row]
        postCell.configurateCell(title: postDetail.title , identifier: postDetail.identifierPost)
        return postCell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let avaibleWidth = view.frame.width - paddingSpace
        let widthPerItem = avaibleWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension CollectionViewController: NetworkReachabilityDelegate {
    
    func listenForReachability(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .notReachable, .unknown:
            print("test")
//            changeTextStatus(status: "Internet connection error")
//            self.stateActivityIndicator (state: false)
            
        default:
            print("test")
//            changeTextStatus(status: "Loading")
//            self.stateActivityIndicator (state: true)
        }
    }
}
