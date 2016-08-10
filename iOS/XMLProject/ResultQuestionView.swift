//
//  ResultQuestionView.swift
//  Superb
//
//  Created by Le Thanh Tan on 6/17/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class ResultQuestionView: UIView {

	@IBOutlet weak var resultImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var contentView: UIView!
  @IBOutlet weak var ctContentHeight: NSLayoutConstraint!
  
	var personality: Personality! {
		didSet {
			titleLabel.text = "\(personality.abbreviation)"
      
      // image
//      if let URLString = personality.imageURL {
//        resultImage.setImageWithURL(NSURL(string: serverUrl + URLString)!, placeholderImage: UIImage(named: "entj"))
//      }
      // Description
      var descriptionString = personality.descriptionPersonality + "\n\n"
      descriptionString = descriptionString + personality.abbreviation + " At Work: \n"
      descriptionString = descriptionString + (personality.atWork ?? "") + "\n\n"
      descriptionString = descriptionString + personality.abbreviation + " Strength: \n"
      descriptionString = descriptionString + (personality.strength ?? "") + "\n\n"
      descriptionString = descriptionString + personality.abbreviation + " Weakness: \n"
      descriptionString = descriptionString + (personality.weakness ?? "")
      
			descriptionLabel.text = descriptionString
      ctContentHeight.constant += descriptionLabel.requiredHeight()
      
      descriptionLabel.layoutIfNeeded()
      self.layoutIfNeeded()
      
    }
	}

	
	override func layoutSubviews() {
		contentView.layer.cornerRadius = 15
	}
	
}
