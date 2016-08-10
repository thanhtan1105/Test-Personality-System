//
//  PersonalityTableCell.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/8/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class PersonalityTableCell: UITableViewCell {

  static let ClassName = "PersonalityTableCell"

  @IBOutlet weak var personalityImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }

  func configure(image image: String, title: String, description: String) {
    personalityImage.image = UIImage(named: image)
    titleLabel.text = title
    descriptionLabel.text = description
  }
  
}
