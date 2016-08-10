//
//  PersonalityViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/8/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class PersonalityViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var containerToggle: UISegmentedControl!
  
  var data: [Personality] = [] {
    didSet {
      dispatch_async(dispatch_get_main_queue()) { 
        self.tableView.reloadData()
        self.collectionView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    callAPIGetInforPersonality() // call api
    
    tableView.estimatedRowHeight = 160.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    // Remove the title of the back button
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
      .Plain, target: nil, action: nil)
    
    tableView.hidden = false
    collectionView.hidden = true
    
  }

  
  @IBAction func didTapToggle(sender: AnyObject) {
    var transitionOptions: UIViewAnimationOptions = [.TransitionFlipFromLeft, .ShowHideTransitionViews]
    var inView: UIView! = collectionView
    var outView: UIView! = tableView
    
    if containerToggle.selectedSegmentIndex == 0 {
      transitionOptions = [.TransitionFlipFromRight, .ShowHideTransitionViews]
      inView = tableView
      outView = collectionView
    }
    
    UIView.transitionWithView(outView, duration: 1.0, options: transitionOptions, animations: {
      outView.hidden = true
      }, completion: nil)
    UIView.transitionWithView(inView, duration: 1.0, options: transitionOptions, animations: {
      inView.hidden = false
      }, completion: nil)
  }
}

extension PersonalityViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(PersonalityTableCell.ClassName) as! PersonalityTableCell
    let personality = data[indexPath.row]
    cell.configure(image: personality.personalityName.lowercaseString, title: personality.abbreviation, description: personality.descriptionPersonality)
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let personality = data[indexPath.row]
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PersonalityDetailViewController") as! PersonalityDetailViewController
    vc.personality = personality
    vc.title = personality.personalityName
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

extension PersonalityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonalityCollectionCell", forIndexPath: indexPath) as! PersonalityCollectionCell
    
    let personality = data[indexPath.row]
    cell.configure(image: personality.personalityName.lowercaseString, title: personality.personalityName)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let personality = data[indexPath.row]
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PersonalityDetailViewController") as! PersonalityDetailViewController
    vc.personality = personality
    vc.title = personality.personalityName
    self.navigationController?.pushViewController(vc, animated: true)    
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let screen = UIScreen.mainScreen().bounds
    return CGSizeMake(screen.width / 2 - 10 , 200)
  }
}


// MARK: - Private Method
extension PersonalityViewController {
  private func callAPIGetInforPersonality() {
    
    // make request
    let session = NSURLSession.sharedSession()
    let url: NSURL = NSURL(string: getInforPersonality)!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // show loading
    LeThanhTanLoading.sharedInstance.showLoadingAddedTo(self.view, animated: true)
    let task = session.dataTaskWithRequest(request) { (data: NSData?, response:NSURLResponse?, error: NSError?) in
      
      if let data = data {
        var dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        dataString = dataString?.stringByReplacingOccurrencesOfString("utf-16", withString: "UTF-8")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\n", withString: "")
        dataString = dataString?.stringByReplacingOccurrencesOfString("\r", withString: "")
        let dataAfter = dataString?.dataUsingEncoding(NSUTF8StringEncoding)
        
        let parser = PersonalityInfoSAXParser()
        let result = parser.xmlToListPersonality(dataAfter!)

        self.data = result
        
        dispatch_async(dispatch_get_main_queue(), {
          // hideloading
          LeThanhTanLoading.sharedInstance.hideLoadingAddedTo(self.view, animated: true)
        })
        
      } else {
        self.showAlertInCorrectNetwork()
      }
    }
    
    task.resume()
  }
  
  
  private func showAlertInCorrectNetwork() {
    dispatch_async(dispatch_get_main_queue()) {
      let alert = UIAlertController(title: "Login Fail", message: "Incorrect username or password", preferredStyle: .Alert)
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
        // hideloading
        LeThanhTanLoading.sharedInstance.hideLoadingAddedTo(self.view, animated: true)
        
      }))
      
      self.presentViewController(alert, animated: true, completion: nil)
      
    }
  }
  
}




