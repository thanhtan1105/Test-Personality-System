
//
//  SingleQuestionView.swift
//  Superb
//
//  Created by Le Thanh Tan on 6/17/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

protocol SingleQuestionViewDelegate: class {
	func singleQuestionView(singleQuestionView: SingleQuestionView, didChoiceAnswerWithButton index: Int)
}

class SingleQuestionView: UIView {

	@IBOutlet weak var currentPositionQuestionLabel: UILabel!
	@IBOutlet weak var detailQuestionLabel: UILabel!

	@IBOutlet weak var choice1Button: UIButton!
	@IBOutlet weak var choice2Button: UIButton!
	@IBOutlet weak var choice3Button: UIButton!
	@IBOutlet weak var choice4Button: UIButton!
	@IBOutlet weak var choice5Button: UIButton!

	weak var delegate: SingleQuestionViewDelegate!
	
	override func layoutSubviews() {
		layoutButton(choice1Button)
		layoutButton(choice2Button)
		layoutButton(choice3Button)
		layoutButton(choice4Button)
		layoutButton(choice5Button)
	}

	private func layoutButton(button: UIButton) {
		button.layer.cornerRadius = button.bounds.size.width / 2
		button.layer.borderColor = UIColor.blackColor().CGColor
		button.layer.borderWidth = 2
		button.clipsToBounds = true
	}

	private func layoutSelectedButton(button: UIButton) {
		button.backgroundColor = UIColor.lightGrayColor()
		button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
	}
	
	private func layoutUnSelectedButton(button: UIButton) {
		button.backgroundColor = UIColor.clearColor()
		button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
	}
	
	func layoutUnSelectedAllButton() {
		layoutUnSelectedButton(choice1Button)
		layoutUnSelectedButton(choice2Button)
		layoutUnSelectedButton(choice3Button)
		layoutUnSelectedButton(choice4Button)
		layoutUnSelectedButton(choice5Button)
	}
	
	@IBAction func onChoiceAnswearTapped(sender: UIButton) {
		layoutUnSelectedAllButton()
		layoutSelectedButton(sender)
		var index = -1
		switch sender {
		case choice1Button:
			index = 1
			break
		case choice2Button:
			index = 2
			break
		case choice3Button:
			index = 3
			break
		case choice4Button:
			index = 4
			break
		case choice5Button:
			index = 5
			break
		default:break
		}
		delegate?.singleQuestionView(self, didChoiceAnswerWithButton: index)
	}
	
	
	
}
