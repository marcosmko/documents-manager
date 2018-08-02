//
//  ServerMock.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

class ServerMock: Server {

    override class func createURLRequest(method: Server.Method, endpoint: String, parameters: [String : Any]?, payload: [String : Any]?) throws -> URLRequest {
        let bundle: Bundle = Bundle(for: self)
        return URLRequest(url: bundle.url(forResource: "UserMock", withExtension: "json")!)
    }

}
