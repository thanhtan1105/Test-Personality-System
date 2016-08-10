//
//  User.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 7/27/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
  var username: String?
  
  init(dic: NSMutableDictionary) {
    self.username = dic.objectForKey("name") as? String
  }
  
  override init() {
    
  }
  
  func toDictionary() -> Dictionary<String, AnyObject> {
    var dic = Dictionary<String, AnyObject>()
    dic["username"] = username
    return dic
  }
  
  func saveToNSUserDefault() {
    let dic = self.toDictionary()
    let defaults = NSUserDefaults.standardUserDefaults()
    if defaults.objectForKey(kUDUser) != nil {
      defaults.removeObjectForKey(kUDUser)
    }
    defaults.setObject(dic, forKey: kUDUser)
    defaults.synchronize()
  }
}
