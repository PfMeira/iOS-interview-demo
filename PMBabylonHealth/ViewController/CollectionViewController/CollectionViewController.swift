  //
//  CollectionViewController.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 17/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nib = UINib(nibName: "PostCell", bundle: nil)
            collectionView?.register(nib, forCellWithReuseIdentifier: "postCell")
        }
    }
    @IBOutlet var postCell: PostCell!
    
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let itemPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    
    let networkManager = NetworkManager.sharedNetworkManager
    var postModel: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateActivityIndicator (state: false)
        getPostsInformations()
        self.title = "Posts"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPostsInformations() {
        
        networkManager.getPostInformations(completed: { result in
            switch result {
            case .success(let posts):
                for i in 0 ..< posts.count {
                    let post = posts[i]
                    guard let userId = post["userId"] as? Int, let identifier = post["id"] as? Int, let title = post["title"] as? String, let body = post["body"] as? String else { return }
                    let postStruct = Posts(userId: userId, identifier: identifier, title: title, body: body)
                    self.postModel.append(postStruct)
                }
                self.collectionView.reloadData()
                self.stateActivityIndicator (state: true)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func stateActivityIndicator (state: Bool) {
        
        if !state {
            activityIndicatorView.isHidden = state
            activityIndicator.startAnimating()
        } else {
            activityIndicatorView.isHidden = state
            activityIndicator.stopAnimating()
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        // id
        let post = postModel[indexPath.row]
        networkManager.getCommentsInformations(userIdentifier: post.identifier, completed: { result in
            
            switch result {
            case .success(let comment):
                print(comment)
                let detailTableViewController = DetailTableViewController()
                self.navigationController?.pushViewController(detailTableViewController, animated: true)
                
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postModel.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as?  PostCell else {
            return UICollectionViewCell()
        }
        let post = postModel[indexPath.row]
        postCell.configurateCell(title: post.title, identifier: post.identifier)
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
