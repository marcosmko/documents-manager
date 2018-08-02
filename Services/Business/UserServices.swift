//
//  UserServices.swift
//  Services
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure
import Persistence

public class UserServices {

    public func login(username: String, password: String, _ completion: ((_ user: User?, _ error: Error?) -> Void)?)  {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var userToBeReturned: User?
            var raisedError: Error? = nil

            do {
                let user: User = try Server.Authentication.login(username: username, password: password)
                try UserDAO.create(user)
                userToBeReturned = user
            } catch let error {
                raisedError = error
            }

            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(userToBeReturned, raisedError) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.serial)
    }
    
    public func fetch(_ completion: ((_ user: User?, _ error: Error?) -> Void)?)  {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var userToBeReturned: User?
            var raisedError: Error? = nil

            do {
                let user: User = try UserDAO.fetch()
                userToBeReturned = user
            } catch let error {
                raisedError = error
            }

            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(userToBeReturned, raisedError) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })

        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.serial)
    }

}
