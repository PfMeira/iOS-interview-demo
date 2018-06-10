//
//  DetailsTableViewController.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 04/04/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

//protocol NibDescriptor {
//    static var nibName: String { get }
//}
//
//extension NibDescriptor {
//    static var nibName: String {
//        return String(describing: self)
//    }
//}

// Cell Registering with Nib - provider a syntax sugar just for registering a cell from its Nib.
// This implies the Cell and Nib files to have the same name.
//extension UITableView {
//    func register<T>(cell :T.Type) where T: CellDescriptor, T: NibDescriptor, T: UITableViewCell {
//        let nib = UINib(nibName: T.nibName, bundle: nil)
//        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }
//}


class DetailsTableViewController: UIViewController, CellDescriptor {
    static var reuseIdentifier: String = ""
    
    
    
    fileprivate enum Constants {
        static let UserCellIdentifier = "userCell"
        static let CommentCellIdentifier = "commentsCell"
        static let MapCellIdentifier = "mapTableViewCell"
        static let NibUserCellIdentifier = "UserCell"
        static let NibCommentsCellIdentifier = "CommentsCell"
        static let NibMapCellIdentifier = "MapTableViewCell"
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            //Register Cell
        
            tableView.register(UINib(nibName:  Constants.NibUserCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.UserCellIdentifier)
            tableView.register(UINib(nibName:  Constants.NibCommentsCellIdentifier, bundle: nil), forCellReuseIdentifier:  Constants.CommentCellIdentifier)
            tableView.register(UINib(nibName:  Constants.NibMapCellIdentifier, bundle: nil), forCellReuseIdentifier:  Constants.MapCellIdentifier)
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var connectionStatusLabel: UILabel!
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var identifierUser: Int?
    var fullPostUser: PostsInformations?
    
    let databaseManager = DatabaseProviderRepresentable.sharedDatabaseManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.sharedNetworkManager.delegateReachability = self
        getFullPost()
    }
    
    func getFullPost() { // passar para uma class
        guard let identifier = identifierUser else { return }
        NetworkManager.sharedNetworkManager.getCommentsInformations(userIdentifier: identifier, completed: { result in
            
            switch result {
            case .success(let numberComments):
                NetworkManager.sharedNetworkManager.getUsersInformations(userIdentifier: identifier, completed: { result in
                    switch result {
                    case .success(let userInformation):
                        guard let addressUser = userInformation["address"] as? [String: Any],
                            let geolocalization = addressUser["geo"]  as? [String: Any]
                            else { return }
                        
                        guard let nameUser = userInformation["name"] as? String,
                            let emailUser = userInformation["email"] as? String,
                            let street = addressUser["street"] as? String,
                            let city = addressUser["city"] as? String,
                            let geoLat = geolocalization["lat"] as? String,
                            let geoLong = geolocalization["lng"] as? String
                            else { return }
                        
                        guard let lat = Double(geoLat),
                            let long = Double(geoLong)
                            else { return }
                        
                        let author = Author.init(nameAuthor: nameUser, emailAuthor: emailUser)
                        let address = Address.init(lat: lat, long: long, cityAddress: city, streetAddress: street)
                        guard let postUser = PostsInformations(userIdentifier: identifier,authorData: author, numberComments: numberComments, addressData: address) as? PostsInformations else { return }
                        
                        self.fullPostUser = postUser
                        
                        self.databaseManager.getPostInformation(postInformations: postUser)
                        self.tableView.reloadData()
                        self.activityIndicatorView.isHidden = true
                        
                    case .failure(let error):
                        print(error)
                        
                        let postInformation = self.databaseManager.getPost(userID: identifier)
                        
                        print(postInformation)
                        
                        
                        if self.databaseManager.getAllPostsInformations().count != 0 {
                            let postInformation = self.databaseManager.getPost(userID: identifier)
                            print(postInformation)
                            
                        } else {
                            self.stateActivityIndicator (state: false)
                            self.changeTextStatus(status: "Internet connection error")
                            
                        }
                        
                    }
                })
            case .failure(let error):
                //TODO 2 rever logica
                
                print(error)
                
//                if self.databaseManager.getAllPostsInformations().count != 0 {
                    let postInformation = self.databaseManager.getPost(userID: identifier)
                    print(postInformation)

                    if postInformation.isEmpty == true {
                        self.stateActivityIndicator (state: false)
                        self.changeTextStatus(status: "Internet connection error")
                        
                    } else {
                        self.fullPostUser = postInformation[0]
                        self.tableView.reloadData()
                        self.stateActivityIndicator (state: true)
                    }
//                } else {
//                    self.stateActivityIndicator (state: false)
//                    self.changeTextStatus(status: "Internet connection error")
//
//                }
            }
        })
    }
    
    func stateActivityIndicator (state: Bool) {
        //TODO FIX ME: - simplificar! usar truques fixes
        let result = state ? true : false
        activityIndicatorView.isHidden = result
        if result {
            activityIndicator.stopAnimating()
            
        } else {
            activityIndicator.startAnimating()
        }
    }
    
    func changeTextStatus(status: String) {
        connectionStatusLabel.text = status
    }
}

extension DetailsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            let mapController = MapController()
            mapController.fullPost = fullPostUser
            self.navigationController?.pushViewController(mapController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 64
        case 1:
            return 40
        case 2:
            //TODO calcular altura da view.
            let sizeMap = (screenHeight - 200)
            return sizeMap
        default:
            return 0
        }
    }
}

extension DetailsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { return UITableViewCell() }
            cell.configurateCell(user: (fullPostUser?.author))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as? CommentsCell else { return UITableViewCell() }
            cell.configurateCell(fullPost: fullPostUser)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapTableViewCell", for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
            cell.configure(fullPost: fullPostUser)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension DetailsTableViewController: NetworkReachabilityDelegate {
    
    func listenForReachability(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .notReachable, .unknown:
            print("notReachable")            
            changeTextStatus(status: "Internet connection error")
            self.stateActivityIndicator (state: false)
            
        default:
            print("Loading")
            changeTextStatus(status: "Loading")
            self.stateActivityIndicator (state: true)
            getFullPost()

        }
    }
}
