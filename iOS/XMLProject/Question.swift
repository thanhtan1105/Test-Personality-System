//
//  Question.swift
//  Superb
//
//  Created by Le Thanh Tan on 6/22/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation


struct Question {
  
  var id: Int!
  var content: String!
  var active: Bool?
  var category: Int!
  var answer: Int?
  
  init() {
    
  }
  
  init(id: Int, content: String, active: Bool, category: Int, answer: Int) {
    self.id = id
    self.content = content
    self.active = active
    self.category = category
    self.answer = answer
  }
  
  init?(dic: NSDictionary) {
    let id = dic["Id"] as! Int
    let content = dic["Content"] as! String
    let active = dic["Active"] as! Bool
    let category = dic["Category"] as! Int
    self.init(id: id, content: content, active: active, category: category, answer: -1)
  }
  
  func toDictionary() -> Dictionary<String, AnyObject> {
    var dic = Dictionary<String, AnyObject>()
    dic["Id"] = id
    dic["Content"] = content
    dic["Active"] = active
    dic["Category"] = category
    return dic
  }
}


// MARK: - Action
extension Question {
  static func fetchDataFromServer() {
    let url: NSURL = NSURL(string: getTemplateQuestion)!
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
    let task = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
      
      var dataString = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
      dataString = dataString?.stringByReplacingOccurrencesOfString("utf-16", withString: "UTF-8")
      dataString = dataString?.stringByReplacingOccurrencesOfString("\n", withString: "")
      dataString = dataString?.stringByReplacingOccurrencesOfString("\r", withString: "")
      let dataAfter = dataString?.dataUsingEncoding(NSUTF8StringEncoding)
      
      let parser = QuestionSAXParser()
      let questionList = parser.xmlToListQuestion(dataAfter!)
      
      // save to DB
      for question in questionList {
        question.saveToDatabase()
      }
    }
    
    task.resume()
  }
  
  func saveToDatabase() -> Bool {
    let result = DBQuestion.saveQuestion(id, content: content, active: active, category: category, answer: answer ?? -1)
    print("id: \(id) save \(result)")
    return result.isSuccess
  }
  
  func updateAnswer() -> Bool {
    let result = DBQuestion.updateQuestion(self.id, answer: self.answer!)
    return result.isSuccess
  }
  
  static func fetchAll() -> (question: [Question]?, error: NSError?) {
    let data = DBQuestion.fetchAll()
    guard data.error == nil else {
      return (nil, data.error)
    }
    
    guard !(data.result is NSNull) else {
      return (nil, nil)
    }
    
    let questionList: [DBQuestion] = data.result as! [DBQuestion]
    // parse from db style to model
    var questionListModel: [Question] = []
    for question in questionList {
      let model = Question(id: question.id!.integerValue,
                           content: question.content!,
                           active: true ,
                           category: question.category!.integerValue,
                           answer: question.category!.integerValue)
      questionListModel.append(model)
    }
    return (questionListModel, nil)
  }
  
  static func resetToDefaultQuestion() -> Bool {
    let result = DBQuestion.resetToDefault()
    return result.isSuccess
  }
  
  func submitQuestionToServer(userID: String, completion onCompletionHandler: ((personality: Personality?, error: NSError?) -> Void)?) {
    
  }

}
