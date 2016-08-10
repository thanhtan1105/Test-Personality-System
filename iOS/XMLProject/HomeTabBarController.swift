//
//  HomeTabBarController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

  static let StoryboardIdentifiter = "HomeTabBarController"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}

extension HomeTabBarController {
  
  
}