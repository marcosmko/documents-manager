//
//  UserDAO.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import CoreData
import Infrastructure

public class UserDAO {
    
    public static func create(_ user: User) throws {
        do {
            CoreDataManager.shared.insertObject(user)
            try CoreDataManager.shared.saveContext()
        } catch {
            throw PersistenceError.databaseFailure
        }
    }
    
    public static func update(_ user: User) throws {
        do {
            try CoreDataManager.shared.saveContext()
        } catch {
            throw MTError.databaseFailure
        }
    }
    
    public static func fetch() throws -> User {
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            if let user = try CoreDataManager.shared.viewContext.fetch(request).last {
                return user
            } else {
                throw PersistenceError.notFound
            }
        } catch {
            throw PersistenceError.databaseFailure
        }
    }
    
}
