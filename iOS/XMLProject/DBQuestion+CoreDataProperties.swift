//
//  DBQuestion+CoreDataProperties.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DBQuestion {

    @NSManaged var active: NSNumber?
    @NSManaged var answer: NSNumber?
    @NSManaged var category: NSNumber?
    @NSManaged var content: String?
    @NSManaged var id: NSNumber?

}
