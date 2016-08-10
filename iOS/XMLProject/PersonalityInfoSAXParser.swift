//
//  PersonalityInfoSAXParser.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/8/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

class PersonalityInfoSAXParser: NSObject {
  
  var parser = NSXMLParser()
  var elements = NSMutableDictionary()
  var element = NSString()
  var personalityList: [Personality] = []
  var personality = Personality()
  
  func xmlToListPersonality(data: NSData) -> [Personality] {
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return personalityList
  }
  
  func xmlToPersonality(data: NSData) -> Personality? {
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return personalityList.first ?? nil
  }
}

extension PersonalityInfoSAXParser: NSXMLParserDelegate {
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
    element = elementName
    if elementName == "tblGroupDTO" {
      elements = NSMutableDictionary()
      element = NSString()
      personality = Personality()
    }
    
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    
    switch element {
    case "name":
      if string.trim().characters.count > 0 {
        personality.personalityName = string.trim()
      }
      break
      
    case "abbreviation":
      if string.trim().characters.count > 0 {
        personality.abbreviation = string.trim()
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
    if elementName == "tblGroupDTO" {
      personalityList.append(personality)
    }
  }
  
}