//
//  Server+User.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure

public extension Server {
    
    public struct Authentication {

        public static func login(username: String, password: String) throws -> User {
            return try Server.request(endpoint: "")
        }

    }

}
