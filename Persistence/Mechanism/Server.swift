//
//  Server.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

public enum ServerError: Error {
    case noResponse
    case error(statusCode: Int, payload: Data?)
}

public class Server {

    private init() { }
    static var current: Server.Type = ServerMock.self
    
    
    public enum Method: String {
        case get, post, put, delete
    }
    
    class func createURLRequest(method: Method, endpoint: String, parameters: [String: Any]? = nil, payload: [String: Any]? = nil) throws -> URLRequest {
        guard let url: URL = URL(string: "" + endpoint) else {
            throw NSError()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let payload = payload {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
        }

        return urlRequest
    }
    
    static func request<T: Decodable>(method: Method, endpoint: String) throws -> T {
        let request: URLRequest = try self.current.createURLRequest(method: method, endpoint: endpoint)
        let (data, response, error) = try URLSession.performSynchronousRequest(request)

        guard error == nil else { throw error! }
        if let data: Data = data, (response as? HTTPURLResponse)?.statusCode == 200 || !(response is HTTPURLResponse)   {
            let decoder: JSONDecoder = JSONDecoder()
            let object: T = try decoder.decode(T.self, from: data)
            return object
        } else {
            throw ServerError.error(statusCode: 200, payload: data)
        }
    }

}
