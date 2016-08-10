//
//  QuestionSAXParser.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

class QuestionSAXParser: NSObject {
  
  var parser = NSXMLParser()
  var totalElement: [Question] = []
  var elements = NSMutableDictionary()
  var element = NSString()
  var question = Question()
  
  override init() {
    
  }
  
  func xmlToListQuestion(data: NSData) -> [Question] {
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return totalElement 
  }
}

extension QuestionSAXParser: NSXMLParserDelegate {
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    element = elementName
    if elementName == "PersonalityQuestionViewModel" {
      elements = NSMutableDictionary()
      element = NSString()
      question = Question()      
    }
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    switch element {
    case "Id":
      if string.trim().characters.count > 0 {
        question.id = Int(string.trim())
      }

      break
    case "Content":
      if string.trim().characters.count > 0 {
        question.content = string.trim()
      }
      
      break
    case "Category":
      if string.trim().characters.count > 0 {
        question.category = Int(string.trim())
      }
      break
    default:
      break
    }
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "PersonalityQuestionViewModel" {
      totalElement.append(question)
    }
  }
  
}