//
//  PersonalityDetailViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/8/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class PersonalityDetailViewController: UIViewController {

  var personality : Personality!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var personalityImage: UIImageView!
  @IBOutlet weak var personalityName: UILabel!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 160.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    personalityImage.image = UIImage(named: personality.personalityName.lowercaseString)
    personalityName.text = personality.abbreviation
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension PersonalityDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionTableCell") as! DescriptionTableCell
    

    switch indexPath.section {
    case 0:
      cell.configure(personality.descriptionPersonality)
      break
    case 1:
      cell.configure(personality.atWork ?? "Update later ")
      break
    case 2:
      cell.configure(personality.strength ?? "Update later ")
      break
    case 3:
      cell.configure(personality.weakness ?? "Update later ")
      break
    default:
      break
    }
    
    return cell
    
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Description"
      
    case 1:
      return "At work"
      
    case 2:
      return "Strength"
    case 3:
      return "Weakness"
      
    default:
      return ""
    }
  }
}
