//
//  UserDefaultsExtension.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case currentAccount
    }


    func set(_ value: Any?, for key: Keys) {
        set(value, forKey: key.rawValue)
    }

    
}
