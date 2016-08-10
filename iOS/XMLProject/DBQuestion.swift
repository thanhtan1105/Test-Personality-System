//
//  DBQuestion.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation
import CoreData

typealias QueryDatabaseResult = (isSuccess: Bool, result: AnyObject?, error: NSError?)

@objc(DBQuestion)
class DBQuestion: NSManagedObject {

  private static var managedContext: NSManagedObjectContext = CoreDataStack().context
  
  
  class func saveQuestion(id: Int, content: String, active: Bool?, category: Int, answer: Int) -> QueryDatabaseResult {
    let questionEntity = NSEntityDescription.entityForName("DBQuestion", inManagedObjectContext: managedContext)
    let question = DBQuestion(entity: questionEntity!, insertIntoManagedObjectContext: managedContext)
    question.id = id
    question.content = content
    question.active = active
    question.category = category
    question.answer = answer
    
    // Save the managed object context
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save:\(error)")
      return (isSuccess: false, result: nil, error)
    }
    return (isSuccess: true, result: nil, nil)
  }
  
  class func fetchAll() -> QueryDatabaseResult {
    let questionFetch = NSFetchRequest(entityName: "DBQuestion")
    do {
      let result = try managedContext.executeFetchRequest(questionFetch)
      return (isSuccess: true, result: result, nil)
    } catch let error as NSError {
      print("Could not fetch: \(error)")
      return (isSuccess: false, result: nil, error)
    }
  }
  
  class func count() -> Int {
    let questionFetch = NSFetchRequest(entityName: "DBQuestion")
    questionFetch.resultType = .CountResultType
    do {
      let result = try managedContext.executeFetchRequest(questionFetch) as! [NSNumber]
      return result.first!.integerValue
      
    } catch let error as NSError {
      
      print("Could not fetch \(error), \(error.userInfo)")
    }
    return 0
  }
  
  class func updateQuestion(id: Int, answer: Int) -> QueryDatabaseResult {
    let questionEntity = NSEntityDescription.entityForName("DBQuestion", inManagedObjectContext: managedContext)
    let batchUpdateRequest = NSBatchUpdateRequest(entity: questionEntity!)
    batchUpdateRequest.resultType = .UpdatedObjectIDsResultType
    batchUpdateRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integer: id))
    let number = NSNumber(integer: answer)
    batchUpdateRequest.propertiesToUpdate = ["answer": number]
    do {
      let batchUpdateResult = try managedContext.executeRequest(batchUpdateRequest) as! NSBatchUpdateResult
      return (isSuccess: true, result: batchUpdateResult, nil)
      
    } catch let error as NSError {
      print("Could not update your answer: \(error)")
    }
    return (isSuccess: true, result: nil, nil)
  }
  
  class func removeAll() {
    
  }
  
  class func resetToDefault() -> QueryDatabaseResult {
    let questionEntity = NSEntityDescription.entityForName("DBQuestion", inManagedObjectContext: managedContext)
    let batchUpdateRequest = NSBatchUpdateRequest(entity: questionEntity!)
    batchUpdateRequest.resultType = .UpdatedObjectIDsResultType
    let number = NSNumber(integer: -1)
    batchUpdateRequest.propertiesToUpdate = ["answer": number]
    do {
      let batchUpdateResult = try managedContext.executeRequest(batchUpdateRequest) as! NSBatchUpdateResult
      return (isSuccess: true, result: batchUpdateResult, nil)
      
    } catch let error as NSError {
      print("Could not update your answer: \(error)")
    }
    return (isSuccess: true, result: nil, nil)
    
  }


}
