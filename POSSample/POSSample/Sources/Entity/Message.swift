//
//  Message.swift
//  POSSample
//
//  Created by T.Muta on 2018/08/03.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import Foundation

struct Message {
    var value: String
}

extension Message: ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    init(stringLiteral value: String) {
        self.value = value
    }
}

extension Message: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    init(integerLiteral value: Int) {
        self.value = String(value)
    }
}
