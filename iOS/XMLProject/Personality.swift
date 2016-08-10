//
//  Personality.swift
//  Superb
//
//  Created by Le Thanh Tan on 6/24/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

class Personality {
	var id: Int!
	var personalityName: String!
	var abbreviation: String!
	var descriptionPersonality: String!
  var atWork: String?
  var strength: String?
  var weakness: String?
  var imageURL: String?
	var active: Bool!
	
  
  init() {
    
  }
  
	init(id: Int, personalityName: String,
	     abbreviation: String, descriptionPersonality: String,
	     atWork: String?, strength: String?,
	     weakness: String?, imageURL: String?,
	     active: Bool) {
    
		self.id = id
		self.personalityName = personalityName
		self.abbreviation = abbreviation
		self.descriptionPersonality = descriptionPersonality
    self.atWork = atWork
    self.strength = strength
    self.weakness = weakness
    self.imageURL = imageURL
		self.active = active
	}
	
	convenience init?(dic: NSDictionary) {
		let id = dic["Id"] as? Int ?? 0
		let personalityName = dic["Name"] as! String
		let abbreviation = dic["Abbreviation"] as! String
		let descriptionPersonality = dic["Description"] as! String
    let atWork = dic["AtWork"] as? String ?? nil
    let strength = dic["Strength"] as? String ?? nil
    let weakness = dic["Weakness"] as? String ?? nil
    let imageURL = dic["ImageUrl"] as? String ?? nil
		let active = dic["Active"] as? Bool ?? true
    
    
		self.init(id: id, personalityName: personalityName,
		          abbreviation: abbreviation, descriptionPersonality: descriptionPersonality,
		          atWork: atWork, strength: strength,
		          weakness: weakness, imageURL: imageURL,
		          active: active)
	}
	
	func toDictionary() -> Dictionary<String, AnyObject> {
		var dic = Dictionary<String, AnyObject>()
		dic["Id"] = id
		dic["Name"] = personalityName
		dic["Abbreviation"] = abbreviation
		dic["Description"] = descriptionPersonality
    dic["AtWork"] = atWork
    dic["Strength"] = strength
    dic["Weakness"] = weakness
    dic["ImageUrl"] = imageURL
		dic["Active"] = active
    
		return dic
	}
	
	func saveToNSUserDefault() {
		let dic = self.toDictionary()
		let defaults = NSUserDefaults.standardUserDefaults()
		if defaults.objectForKey(kUDPersonality) != nil {
			defaults.removeObjectForKey(kUDPersonality)
		}
		defaults.setObject(dic, forKey: kUDPersonality)
		defaults.synchronize()
	}
	
	class func isExistOnNSUserDefault() -> Bool {
		let userDic = NSUserDefaults.standardUserDefaults().objectForKey(kUDPersonality) as? NSDictionary ?? nil
		if userDic == nil {
			return false
		}		
		return true
	}
	
}