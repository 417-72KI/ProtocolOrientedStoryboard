//
//  StoryboardExtensions.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/25.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

protocol StoryboardIdentifiable: Identifiable {
}

// MARK: - UITableViewCell
extension UITableViewCell {
    /// Usage:
    /// let cell: CellClassName = .dequeue(from: tableView, for: indexPath)
    ///
    /// - Parameters:
    ///   - tableView: table view which cell registered
    ///   - indexPath: index path
    /// - Returns: dequeued cell
    class func dequeue<T: UITableViewCell>(from tableView: UITableView, `for` indexPath: IndexPath) -> T where T: StoryboardIdentifiable {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Identifier \"\(T.identifier)\" for class \"\(T.self)\" is not registered in \(tableView)")
        }
        return cell
    }
}

// MARK: - UIStoryboardSegue
extension UIStoryboardSegue {
    /// destinationを返す
    /// NavigationControllerやTabBarControllerが噛んでいる場合は再帰的に階層を掘っていく
    var detectedDestination: UIViewController {
        return detectActiveViewController(destination)
    }
}

private extension UIStoryboardSegue {
    func detectActiveViewController(_ target: UIViewController) -> UIViewController {
        switch target {
        case let nav as UINavigationController:
            guard let top = nav.topViewController else { return nav }
            return detectActiveViewController(top)
        case let tab as UITabBarController:
            guard let current = tab.selectedViewController else { return tab }
            return detectActiveViewController(current)
        default:
            return target
        }
    }
}

// MARK: - UIViewController
extension UIViewController {
    /// 同storyboard内にあるViewControllerを生成する
    ///
    /// - Returns: 生成されたViewController
    func instantiateIdentifiedViewControllerInSameStoryboard<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let storyboard = storyboard else {
            fatalError("\(self) is not instantiate from storyboard.")
        }
        return T.instantiate(from: storyboard)
    }
}

private extension UIViewController {
    class func instantiate<T: UIViewController>(from storyboard: UIStoryboard) -> T where T: StoryboardIdentifiable {
        guard let vc = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Identifier \"\(T.identifier)\" for class \"\(T.self)\" is not defined in \(storyboard)")
        }
        return vc
    }
}
