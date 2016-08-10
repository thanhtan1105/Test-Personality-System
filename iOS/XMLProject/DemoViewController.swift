//
//  ViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 7/27/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var parser = NSXMLParser()
  var totalElement: [NSMutableDictionary] = []
  var elements = NSMutableDictionary()
  var element = NSString()
  var address = NSMutableString()
  var city = NSMutableString()
  var customerId = NSMutableString()
  var name = NSMutableString()
  var phone = NSMutableString()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    beginParsing()
  }
  
  func beginParsing() {
    let path = NSBundle.mainBundle().pathForResource("Customers", ofType: "xml")
    parser = NSXMLParser(data: NSData(contentsOfFile: path!)!)
    parser.delegate = self
    parser.parse()
    print(totalElement)
  }

}

extension ViewController: NSXMLParserDelegate {
  func parser(parser: NSXMLParser, didStartElement elementName: String,
              namespaceURI: String?, qualifiedName qName: String?,
              attributes attributeDict: [String : String]) {
    
    element = elementName
    if (elementName as NSString).isEqualToString("customer") {
      elements = NSMutableDictionary()
      elements = [:]
      address = NSMutableString()
      address = ""
      city = NSMutableString()
      city = ""
      customerId = NSMutableString()
      customerId = ""
      name = NSMutableString()
      name = ""
      phone = NSMutableString()
      phone = ""
    }    
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    switch element {
    case "address":
      address.appendString(string.trim())
      break
    case "city":
      city.appendString(string.trim())
      break
    case "customerId":
      customerId.appendString(string.trim())
      break
    case "name":
      name.appendString(string.trim())
      break
    case "phone":
      phone.appendString(string.trim())
      break
      
    default:
      break
    }
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String,
              namespaceURI: String?, qualifiedName qName: String?) {
    
    if (elementName as NSString).isEqualToString("customer") {
      if !address.isEqual(nil) {
        elements.setObject(address, forKey: "address")
        
      }
      if !city.isEqual(nil) {
        elements.setObject(city, forKey: "city")
        
      }
      if !customerId.isEqual(nil) {
        elements.setObject(customerId, forKey: "customerId")
        
      }
      if !name.isEqual(nil) {
        elements.setObject(name, forKey: "name")
        
      }
      if !phone.isEqual(nil) {
        elements.setObject(phone, forKey: "phone")
      }
      
      totalElement.append(elements)
    }
  }
}

extension String {
  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(
      NSCharacterSet.whitespaceAndNewlineCharacterSet()
    )
  }
}