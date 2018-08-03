//
//  TwitterDataStore.swift
//  POSSample
//
//  Created by T.Muta on 2018/07/24.
//  Copyright © 2018年 417.72KI. All rights reserved.
//

import Foundation
import TwitterKit
import RxSwift

struct TwitterDataStore {
    private let client = TWTRTwitter.sharedInstance()
}

extension TwitterDataStore {
    var hasLoggedInUsers: Bool {
        return TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()
    }

    func fetchUsers() -> Observable<[TWTRUser]> {
        let sessionList = TWTRTwitter.sharedInstance().sessionStore.existingUserSessions().compactMap { $0 as? TWTRAuthSession }
        if sessionList.isEmpty {
            return Observable.empty()
        }
        return Observable.create({ observer in
            let client = TWTRAPIClient()
            let params = ["user_id": sessionList.compactMap { $0.userID }.joined(separator: ",")]
            var clientError: NSError?
            let url = "https://api.twitter.com/1.1/users/lookup.json"
            let request = client.urlRequest(withMethod: "GET", urlString: url, parameters: params, error: &clientError)
            let progress = client.sendTwitterRequest(request) { _, data, error in
                defer {
                    observer.onCompleted()
                }
                if let data = data {
                    do {
                        let usersJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]]
                        let users = usersJson.flatMap { $0.compactMap { TWTRUser(jsonDictionary: $0) } } ?? []
                        observer.onNext(users)
                    } catch {
                        observer.onError(error)
                    }
                }
                if let error = error {
                    observer.onError(error)
                }
            }
            return Disposables.create {
                progress.cancel()
            }
        })
    }

    func login(with vc: UIViewController) -> Observable<TWTRSession> {
        return Observable.create({ observer in
            TWTRTwitter().logIn(with: vc) { session, error in
                defer {
                    observer.onCompleted()
                }
                if let session = session {
                    observer.onNext(session)
                }
                if let error = error {
                    observer.onError(error)
                }
            }

            return Disposables.create {
            }
        })
    }

    func getUser(session: TWTRSession) -> Observable<TWTRUser> {
        return Observable.create({ observer in
            TWTRAPIClient().loadUser(withID: session.userID, completion: { user, error in
                defer {
                    observer.onCompleted()
                }
                if let user = user {
                    observer.onNext(user)
                }
                if let error = error {
                    observer.onError(error)
                }
            })
            return Disposables.create {
            }
        })
    }

    func getSession(userID: String) -> TWTRAuthSession? {
        return TWTRTwitter.sharedInstance().sessionStore.session(forUserID: userID)

    }
}
