//
//  User.swift
//  Infrastructure
//
//  Created by Marcos Kobuchi on 01/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import CoreData

public final class User: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var phone: String?
}
