//
//  SettingViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/9/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func onLogoutTapped(sender: UIButton) {
    
    // remove object
    NSUserDefaults.standardUserDefaults().removeObjectForKey("kUDCurrentQuestion")
    NSUserDefaults.standardUserDefaults().removeObjectForKey("kUDPersonality")
    NSUserDefaults.standardUserDefaults().removeObjectForKey("kUDUser")
    NSUserDefaults.standardUserDefaults().removeObjectForKey("kUDWantToRetestPersonality")
    
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
    
    appDelegate?.changeRootView(vc)
  }

}
