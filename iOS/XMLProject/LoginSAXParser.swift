//
//  LoginSAXParser.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/3/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

class LoginSAXParser: NSObject {
  
  var parser = NSXMLParser()
  var user: User = User()
  var isSucess: Int!
  var elements = NSMutableDictionary()
  var element = NSString()
  var question = Question()

  override init() {
    
  }
  
  func xmlToListQuestion(data: NSData) -> (isSucess: Bool, user: User?) {
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    
    if isSucess == 1 {
      return (isSucess: true, user: user)
    } else {
      return (isSucess: false, user: nil)
    }
  }
  
}

extension LoginSAXParser: NSXMLParserDelegate {
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    element = elementName
    
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    switch element {
    case "isSuccess":
      if string.trim().characters.count > 0 {
        isSucess = Int(string.trim())
      }
      break
      
    case "username":
      if string.trim().characters.count > 0 {
        user.username = string.trim()
      }
      break
      
    default:
      break
    }
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
  }
}