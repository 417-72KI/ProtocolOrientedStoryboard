//
//  UIImageViewExtension.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/25.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit
import RxSwift

extension UIImageView {
    func load(url: URL) {
        _ = URLSession.shared.rx.response(request: URLRequest(url: url))
            .subscribeOn(SerialDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _, data in
                self.image = UIImage(data: data)
            }, onError: { error in
                log.error(error)
            }, onCompleted: {
                self.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 1
                }
            })
    }
}
