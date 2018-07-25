//
//  ViewController.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let dataStore = TwitterDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !dataStore.hasLoggedInUsers {
            let alert = UIAlertController(title: "アカウントがいるよ！", message: "設定画面に行くよ！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "accounts", sender: self)
            }))
            present(alert, animated: true, completion: nil)
        }
        self.performSegue(withIdentifier: "accounts", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    @IBAction func backToTop(_ sender: UIStoryboardSegue) {

    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {

}
