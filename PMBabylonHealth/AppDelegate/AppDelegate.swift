//
//  AppDelegate.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 15/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let collectionViewController = CollectionViewController(nibName: "CollectionViewController", bundle: nil) as CollectionViewController
        collectionViewController.title = "Posts"
        navController = UINavigationController(rootViewController: collectionViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
