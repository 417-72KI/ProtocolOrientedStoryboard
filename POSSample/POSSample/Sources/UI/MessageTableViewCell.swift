//
//  FourthTableViewCell.swift
//  POSSample
//
//  Created by T.Muta on 2018/08/17.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, StoryboardIdentifiable {

    var message: Message {
        get {
            return Message(stringLiteral: textLabel?.text ?? "")
        }
        set {
            textLabel?.text = newValue.value
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
