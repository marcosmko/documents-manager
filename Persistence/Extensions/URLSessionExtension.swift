//
//  URLSessionExtension.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

internal extension URLSession {
    
    internal static func performSynchronousRequest(_ request: URLRequest) throws -> (Data?, URLResponse?, Error?) {
        var serverData: Data?
        var serverResponse: URLResponse?
        var serverError: Error?

        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error -> () in

            serverData = data
            serverResponse = response
            serverError = error

            semaphore.signal()
        }).resume()

        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        return (serverData, serverResponse, serverError)
    }
    
}

