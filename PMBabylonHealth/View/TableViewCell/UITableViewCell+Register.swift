//
//  UITableViewCell+Register.swift
//  PMBabylonHealth
//
//  Created by Pedro Meira on 09/06/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit


protocol CellDescriptor {
    static var reuseIdentifier: String { get }
}

extension CellDescriptor where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableView {
    func register<T>(cell: T.Type) where T: CellDescriptor, T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
