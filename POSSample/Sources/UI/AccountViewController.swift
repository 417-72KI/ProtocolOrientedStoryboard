//
//  AccountViewController.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import UIKit
import RxSwift
import TwitterKit

class AccountViewController: UIViewController {
    let dataStore = TwitterDataStore()
    let disposeBag = DisposeBag()

    private var users: [TWTRUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataStore.fetchUsers().subscribe(onNext: { list in
            log.debug(list)
        }, onError: { error in
            log.error(error)
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        log.debug(segue)
    }

}

extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
