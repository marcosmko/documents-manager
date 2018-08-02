//
//  CoredataManager.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import CoreData

public final class CoreDataManager {
    
    // Avoid instantiation
    private init() {}
    
    // Shared Resource
    public static var shared: CoreDataManager = CoreDataManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */

        guard let bundle = Bundle(for: type(of: self)).url(forResource: "MobileTest", withExtension: "momd") else {
            fatalError("Bundle not found!")
        }

        guard let objectModel: NSManagedObjectModel = NSManagedObjectModel(contentsOf: bundle) else {
            fatalError("Object Model not found!")
        }

        let container = NSPersistentContainer(name: "MobileTest", managedObjectModel: objectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Core Data Saving support

    public func saveContext() throws {
        let context: NSManagedObjectContext = self.viewContext
        if context.hasChanges {
            try context.save()
        }
    }

    public func insertObject(_ object: NSManagedObject) {
        let context: NSManagedObjectContext = self.viewContext
        context.insert(object)
    }

}
