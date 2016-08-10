//
//  LoginViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 7/27/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    usernameTextField.attributedPlaceholder = NSAttributedString(string:"Username",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
    
    
    passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
                                                                 attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
    
  }
  
  
  @IBAction func onSignInTapped(sender: UIButton) {
    let url: NSURL = NSURL(string: loginURL)!
    
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
    let username = usernameTextField.text!.trim()
    let password = passwordTextField.text!.trim()
    
    let postString = "username=\(username)&password=\(password)"
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // show loading
    LeThanhTanLoading.sharedInstance.showLoadingAddedTo(self.view, animated: true)
    let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
      if let data = data {
        var dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        dataString = dataString?.stringByReplacingOccurrencesOfString("utf-16", withString: "UTF-8")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\n", withString: "")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\r", withString: "")
        let dataAfter = dataString?.dataUsingEncoding(NSUTF8StringEncoding)
        
        let parser = LoginSAXParser()
        let result = parser.xmlToListQuestion(dataAfter!)
        
        if result.isSucess {
          result.user?.saveToNSUserDefault()
          self.callAPIGetPersonality(username) // call to get personality
          
        } else {
          self.showAlertInCorrectNetwork()
        }
      } else {
        self.showAlertInCorrectNetwork()
      }
      
    }
    
    task.resume()

  }

 
  private func callAPIGetPersonality(userName: String) {
    // get param
    let getString = "?username=\(userName)"
    let url: NSURL = NSURL(string: getPersonalityURL + getString)!
    
    // session
    let session = NSURLSession.sharedSession()
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
      if let data = data {
        var dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        dataString = dataString?.stringByReplacingOccurrencesOfString("utf-16", withString: "UTF-8")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\n", withString: "")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\r", withString: "")
        let dataAfter = dataString?.dataUsingEncoding(NSUTF8StringEncoding)
        
        let parser = PersonalityInfoSAXParser()
        let result: Personality? = parser.xmlToPersonality(dataAfter!)
        
        if let result = result {
          result.saveToNSUserDefault()
        }
        
        dispatch_async(dispatch_get_main_queue(), {
          let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyboard.instantiateViewControllerWithIdentifier(HomeTabBarController.StoryboardIdentifiter)
          
          appDelegate?.changeRootView(vc)
        })

        
      } else {
        self.showAlertWrongGetFailPersonality()
      }
      
      dispatch_async(dispatch_get_main_queue(), {
        // hideloading
        LeThanhTanLoading.sharedInstance.hideLoadingAddedTo(self.view, animated: true)
      })
    }
    
    task.resume()

  }
  
  private func showAlertWrongGetFailPersonality() {
    dispatch_async(dispatch_get_main_queue()) {
      let alert = UIAlertController(title: "Login Fail", message: "Something when wrong, try later", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
        
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  private func showAlertInCorrectNetwork() {
    dispatch_async(dispatch_get_main_queue()) { 
      let alert = UIAlertController(title: "Login Fail", message: "Incorrect username or password", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
        
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
}



