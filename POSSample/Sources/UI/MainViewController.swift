//
//  MainViewController.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TwitterKit

protocol MainView: class {
    var user: TWTRUser? { get set }
}

class MainViewController: UIViewController, MainView {

    let dataStore = TwitterDataStore()

    var user: TWTRUser? {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard dataStore.hasLoggedInUsers else {
            let alert = UIAlertController(title: "アカウントがいるよ！", message: "設定画面に行くよ！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "accounts", sender: self)
            }))
            present(alert, animated: true, completion: nil)
            return
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let accountView = segue.destination as? AccountView {
            accountView.delegate = self
        }
    }
}

extension MainViewController {
    @IBAction func backToTop(_ sender: UIStoryboardSegue) {

    }
}

private extension MainViewController {
    var pageController: UIPageViewController {
        return childViewControllers.compactMap { $0 as? UIPageViewController }.first ?? { fatalError("Page View Controller doesn't included") }()
    }
}

extension MainViewController: AccountViewDelegate {
    func accountView(_ accountView: AccountView, didUserChange user: TWTRUser) {
        UserDefaults.standard.set(user, for: .currentAccount)
        self.user = user
    }
}
