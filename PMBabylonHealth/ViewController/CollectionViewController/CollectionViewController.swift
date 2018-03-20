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
    
    fileprivate let itemPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsetsMake(30.0, 10.0, 30.0, 10.0)
    
    let networkManager = NetworkManager.sharedNetworkManager
    var postModel: [Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Posts"
        
        networkManager.getPostInformations(completed: { result in
            switch result {
            case .success(let posts):
                for i in 0 ..< posts.count {
                    let post = posts[i]
                    guard let userId = post["userId"] as? Int, let identifier = post["id"] as? Int, let title = post["title"] as? String, let body = post["body"] as? String else {
                        return }
                    let postStruct = Posts(userId: userId, identifier: identifier, title: title, body: body)
                    self.postModel.append(postStruct)
                }
                self.collectionView.reloadData()
                print(posts)
            case .failure(let error):
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailTableViewController = DetailTableViewController()
        self.navigationController?.pushViewController(detailTableViewController, animated: true)
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
