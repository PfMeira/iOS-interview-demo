//
//  DetailTableViewController.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 18/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            let userCell = UINib(nibName: "UserCell", bundle: nil)
            tableView.register(userCell, forCellReuseIdentifier: "userCell")
            
            let commentsCell = UINib(nibName: "CommentsCell", bundle: nil)
            tableView.register(commentsCell, forCellReuseIdentifier: "commentsCell")
            
            let mapCell = UINib(nibName: "MapViewCell", bundle: nil)
            tableView.register(mapCell, forCellReuseIdentifier: "mapViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = CGFloat()
        if indexPath.row == 0 {
            height = 70
        } else if indexPath.row == 1 {
            height = 40
        } else {
            height = 250
        }
        return height
    }
}

extension DetailTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else {
                return UITableViewCell()
            }
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as? CommentsCell else {
                return UITableViewCell()
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapViewCell", for: indexPath) as? MapViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
