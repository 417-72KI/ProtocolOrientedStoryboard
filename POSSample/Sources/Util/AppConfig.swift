//
//  AppConfig.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    let logger = XCGLogger()
    logger.setup(level: .debug, showLogIdentifier: true, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: nil)
    return logger
}()

struct AppConfig {
    private let config: [AnyHashable: [AnyHashable: Any]]

    init() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist") else { fatalError("Config.plist not found.") }
        self.init(path: path)
    }


    init(path: String) {
        guard let config = NSDictionary(contentsOfFile: path) as? [AnyHashable: [AnyHashable: Any]] else { fatalError("\"\(path)\" is not valid format.") }
        self.config = config
    }
}

extension AppConfig {
    struct Twitter {
        let consumerKey: String
        let consumerSecret: String
    }

    var twitter: Twitter {
        guard let data = config["twitter"] as? [AnyHashable : String] else { fatalError("Config key \"twitter\" not found") }
        guard let consumerKey = data["consumer_key"], let consumerSecret = data["consumer_secret"] else { fatalError("Invalid format") }
        return Twitter(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
}
