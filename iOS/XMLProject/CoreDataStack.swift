//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Le Thanh Tan on 4/6/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import CoreData

class CoreDataStack {
  let modelName = "XMLProject"
  
  static var sharedInstance: CoreDataStack = {
    return CoreDataStack()
  }()
  
  // 1
  lazy var context: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(
      concurrencyType: .MainQueueConcurrencyType)
    
    managedObjectContext.persistentStoreCoordinator = self.psc
    return managedObjectContext
  }()
  
  // 2
  private lazy var psc: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
    let url = self.applicationDocumentDirectory.URLByAppendingPathComponent(self.modelName)
    
    do {
      let options = [NSMigratePersistentStoresAutomaticallyOption : true]
      try coordinator.addPersistentStoreWithType( NSSQLiteStoreType, configuration: nil, URL: url, options: options)
    } catch {
      print("Error adding persistent store.")
    }
    return coordinator
  }()
  
  //3
  private lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName,
                                                        withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  private lazy var applicationDocumentDirectory: NSURL = {
    let urls = NSFileManager.defaultManager().URLsForDirectory(
      .DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1]
  }()
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        print("Error: \(error.localizedDescription)")
        abort()
      }
    }
  }
  
}
