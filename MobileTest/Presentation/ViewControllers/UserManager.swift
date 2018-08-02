//
//  UserManager.swift
//  MobileTest
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure
import Services

protocol UserManagerDelegate: class {
    func fetchSuccess(user: User)
    func fetchFailure(error: Error)
}

public class UserManager {

    private weak var delegate: UserManagerDelegate?
    init(delegate: UserManagerDelegate) {
        self.delegate = delegate
    }

    public func fetch() {
        UserServices.fetch { (user, error) in
            if let user: User = user {
                self.delegate?.fetchSuccess(user: user)
            } else {
                self.delegate?.fetchFailure(error: error!)
            }
        }
    }
}
