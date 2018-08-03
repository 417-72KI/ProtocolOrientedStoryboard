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

protocol AccountViewDelegate: class {
    func accountView(_ accountView: AccountView, didUserChange user: TWTRUser)
}

protocol AccountView: class {
    var delegate: AccountViewDelegate? { get set }
}

class AccountViewController: UIViewController, AccountView {
    let dataStore = TwitterDataStore()
    let disposeBag = DisposeBag()

    weak var delegate: AccountViewDelegate?

    @IBOutlet private weak var tableView: UITableView!

    private var users: [TWTRUser] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataStore.fetchUsers()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { list in
                self.users = list
            }, onError: { error in
                log.error(error)
            }, onCompleted: {
                if self.users.isEmpty {
                    self.addNewAccount()
                }
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension AccountViewController {
    func addNewAccount() {
        dataStore.login(with: self)
            .flatMap { return self.dataStore.getUser(session: $0) }
            .subscribe(onNext: { user in
            log.debug(user)
            self.users.append(user)
        }, onError: { error in
            log.error(error)
        }).disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension AccountViewController {
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addNewAccount()
    }
}

// MARK: - UITableViewDataSource
extension AccountViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AccountTableViewCell = .dequeue(from: tableView, for: indexPath)
        cell.user = users[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.accountView(self, didUserChange: users[indexPath.row])
        performSegue(withIdentifier: "finish", sender: nil)
    }
}
