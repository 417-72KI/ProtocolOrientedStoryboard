//
//  StoryboardExtensions.swift
//  POSSample
//
//  Created by T.Muta on 2018/08/17.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var identifier: String { get }
}

extension StoryboardIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    class func dequeue<T: UITableViewCell>(from tableView: UITableView, for indexPath: IndexPath) -> T where T: StoryboardIdentifiable {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Identifier \"\(T.identifier)\" for class \"\(T.self)\" is not registered in \(tableView)")
        }
        return cell
    }
}
