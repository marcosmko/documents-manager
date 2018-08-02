//
//  UserExtensin.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import CoreData
import Infrastructure

extension User: Decodable {
    
    public enum CodingKeys: String, CodingKey {
        case name, email, address, phone
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    convenience public init() {
        let managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.viewContext
        let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)!
        self.init(entity: entityDescription, insertInto: nil)
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.email = try values.decode(String.self, forKey: .email)
        self.address = try values.decode(String.self, forKey: .address)
        self.phone = try values.decode(String.self, forKey: .phone)
    }

}
