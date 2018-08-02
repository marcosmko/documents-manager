//
//  UserViewController.swift
//  MobileTest
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit
import Infrastructure
import Services

public class UserViewController: UIViewController {

    @IBOutlet public weak var pictureImageView: UIImageView!
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var emailLabel: UILabel!
    @IBOutlet public weak var phoneLabel: UILabel!
    @IBOutlet public weak var addressLabel: UILabel!

    private lazy var manager: UserManager = UserManager(delegate: self)

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.manager.fetch()
    }

}

extension UserViewController: UserManagerDelegate {

    func fetchSuccess(user: User) {
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.phoneLabel.text = user.phone
        self.addressLabel.text = user.address
    }
    
    func fetchFailure(error: Error) {
        
    }

}
