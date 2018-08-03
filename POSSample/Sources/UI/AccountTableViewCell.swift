//
//  AccountTableViewCell.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/25.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit
import TwitterKit
import RxSwift

class AccountTableViewCell: UITableViewCell {

    // MARK: Properties
    private var _user: TWTRUser! {
        didSet {
            if let user = _user {
                updateView(user: user)
            }
        }
    }

    // MARK: Outlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var accountLabel: UILabel!

    // MARK: View Controller Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Private Functions
private extension AccountTableViewCell {
    func updateView(user: TWTRUser) {
        if let url = URL(string: user.profileImageURL) {
            iconImageView.load(url: url)
        }
        nameLabel.text = user.name
        accountLabel.text = user.screenName
    }
}

// MARK: - TWTRUserView
extension AccountTableViewCell: TWTRUserView {
    var user: TWTRUser {
        set {
            _user = newValue
        }

        get {
            return _user
        }
    }
}

// MARK: - StoryboardIdentifiable
extension AccountTableViewCell: StoryboardIdentifiable {
    static let identifier: String = "accountCell"
}
