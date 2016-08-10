//
//  PersonalityParser.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/3/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

class PersonalitySAXParser: NSObject {
  
  var parser = NSXMLParser()
  var isSucess: Int!
  var elements = NSMutableDictionary()
  var element = NSString()
  var personality: Personality = Personality()
  
  func xmlToListQuestion(data: NSData) -> (isSucess: Bool, personality: Personality?){
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()

    return (isSucess: true, personality: personality)

  }
}

extension PersonalitySAXParser: NSXMLParserDelegate {
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    element = elementName
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    
    switch element {
    case "isSucess":
      if string.trim().characters.count > 0 {
        isSucess = Int(string.trim())
      }
      
      break
    case "abbreviation":
      if string.trim().characters.count > 0 {
        personality.abbreviation = string.trim()
      }
      
      break
    case "name":
      if string.trim().characters.count > 0 {
        personality.personalityName = string.trim()
      }
      
      break
    case "description":
      if string.trim().characters.count > 0 {
        personality.descriptionPersonality = string.trim()
      }
      
      break
    case "atWork":
      if string.trim().characters.count > 0 {
        personality.atWork = string.trim()
      }
      
      break
    case "strength":
      if string.trim().characters.count > 0 {
        personality.strength = string.trim()
      }
      
      break
    case "weakness":
      if string.trim().characters.count > 0 {
        personality.weakness = string.trim()
      }
      
      break
    default:
      break
    }
    
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
  }
}