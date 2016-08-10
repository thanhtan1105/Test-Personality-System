//
//  QuestionViewController.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

  var questionList: [Question] = []
  var currentQuestion = NSUserDefaults.standardUserDefaults().objectForKey(kUDCurrentQuestion) as? Int ?? 0
  
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var backButton: UIButton!
  weak var singleQuestionView: SingleQuestionView!
  weak var resultQuestionView: ResultQuestionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initLayout()
    // load question
    questionList = Question.fetchAll().question!
    
    if currentQuestion == kUDQuestionCount - 1 {
      nextButton.setTitle("Result", forState: UIControlState.Normal)
    } else if currentQuestion == 51 {
      currentQuestion = 0
    }
    
    loadNewQuestionWithIndex(currentQuestion)
    
    // if user have already personality
    guard (NSUserDefaults.standardUserDefaults().objectForKey(kUDPersonality) as? NSDictionary) == nil else {
      let personality = NSUserDefaults.standardUserDefaults().objectForKey(kUDPersonality) as? NSDictionary
      let currentTitle = NSUserDefaults.standardUserDefaults().objectForKey(kUDWantToRetestPersonality) as? String ?? "Retest"
      nextButton.setTitle(currentTitle, forState: UIControlState.Normal)
      
      // layout
      resultQuestionView.hidden = false
      singleQuestionView.hidden = true
      nextButton.enabled = true
      backButton.hidden = true
      self.resultQuestionView.personality = Personality(dic: personality!)
      return
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


  @IBAction func onBackTapped(sender: UIButton) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func onBackQuestionTapped(sender: UIButton) {
    guard currentQuestion != 0 else {
      return
    }
    
    currentQuestion -= 1
    // show previous question
    NSUserDefaults.standardUserDefaults().setObject(currentQuestion, forKey: kUDCurrentQuestion)
    loadNewQuestionWithIndex(currentQuestion)
    
    nextButton.enabled = false
    nextButton.setTitle("Next", forState: UIControlState.Normal)
  }
  
  
  @IBAction func onNextTapped(sender: UIButton) {
    // current button == Result
    guard nextButton.currentTitle != "Result" else {
      callAPISendAnswer()
      return
    }
    
    guard nextButton.currentTitle != "Finish" else {
      self.navigationController?.popViewControllerAnimated(true)
      return
    }
    
    guard nextButton.currentTitle != "Retest" else {
      resultQuestionView.hidden = true
      singleQuestionView.hidden = false
      nextButton.enabled = false
      backButton.hidden = false
      nextButton.setTitle("Next", forState: UIControlState.Normal)

      return
    }
    
    
    questionList[currentQuestion].updateAnswer() // save answer

    // show next question
    currentQuestion = currentQuestion + 1
    NSUserDefaults.standardUserDefaults().setObject(currentQuestion, forKey: kUDCurrentQuestion)
    NSUserDefaults.standardUserDefaults().synchronize()
    loadNewQuestionWithIndex(currentQuestion)
    nextButton.enabled = false
    
    if currentQuestion == kUDQuestionCount - 1 {
      nextButton.setTitle("Result", forState: UIControlState.Normal)
      
    }
  }
  
  
}


// MARK :- Private Method
extension QuestionViewController {
  private func initLayout() {
    nextButton.enabled = false    
    
    singleQuestionView = NSBundle.mainBundle().loadNibNamed("SingleQuestionView",
                                                            owner: self,
                                                            options: nil)[0] as! SingleQuestionView
    singleQuestionView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: contentView.frame.size.width,
                                      height: contentView.frame.size.height)
    singleQuestionView.layer.cornerRadius = 15
    singleQuestionView.delegate = self
    
    contentView.addSubview(singleQuestionView)
    
    resultQuestionView = NSBundle.mainBundle().loadNibNamed("ResultQuestionView", owner: self, options: nil)[0] as! ResultQuestionView
    resultQuestionView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    resultQuestionView.layer.cornerRadius = 15
    resultQuestionView.hidden = true
    contentView.addSubview(resultQuestionView)
  }
  
  private func loadNewQuestionWithIndex(index: Int) {
    singleQuestionView.currentPositionQuestionLabel.text = "\(index + 1) / \(kUDQuestionCount)"
    singleQuestionView.layoutUnSelectedAllButton()
    singleQuestionView.detailQuestionLabel.text = questionList[index].content
  }
  
  private func callAPISendAnswer() {
    // get DATA
    let username = NSUserDefaults.standardUserDefaults().objectForKey(kUDUser)!.objectForKey("username") as! String
    var result: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    
    result += "<Questions>"
    for question in questionList {
      result += "<Question>"
      result += "<ID>\(question.id)</ID>"
      result += "<Answer>\(question.answer!)</Answer>"
      result += "<Category>\(question.category)</Category>"
      result += "</Question>"
    }
    result += "</Questions>"
    
    let postString = "username=\(username)&result=\(result)"
    
    // make request
    let session = NSURLSession.sharedSession()
    let url: NSURL = NSURL(string: sendPersonalityAnswerURL)!
    let request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "POST"
    request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
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
        
        let parser = PersonalitySAXParser()
        let result = parser.xmlToListQuestion(dataAfter!)
        
        if result.isSucess {
          result.personality?.saveToNSUserDefault()
          dispatch_async(dispatch_get_main_queue(), {
            // change layout after call result success
            self.singleQuestionView.hidden = true
            self.resultQuestionView.personality = result.personality
            self.resultQuestionView.hidden = false
            self.contentView.layer.opacity = 1.0
            self.nextButton.setTitle("Finish", forState: UIControlState.Normal)
            self.backButton.hidden = true
            
            // reset
            self.currentQuestion = 0
            NSUserDefaults.standardUserDefaults().setObject(self.currentQuestion, forKey: kUDCurrentQuestion)
            NSUserDefaults.standardUserDefaults().setObject("Retest", forKey: kUDWantToRetestPersonality)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // hideloading
            LeThanhTanLoading.sharedInstance.hideLoadingAddedTo(self.view, animated: true)

          })
          
        } else {
          self.showAlertInCorrectNetwork()
        }        
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

extension QuestionViewController: SingleQuestionViewDelegate {
  func singleQuestionView(singleQuestionView: SingleQuestionView,
                          didChoiceAnswerWithButton index: Int) {
    let helloIndex = index
    questionList[currentQuestion].answer = helloIndex
    print(index)
    print(questionList[currentQuestion].answer)
    nextButton.enabled = true
  }
}
