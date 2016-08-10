//
//  PersonalityCollectionCell.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/9/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class PersonalityCollectionCell: UICollectionViewCell {
  
  
  @IBOutlet weak var personalityImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  
  func configure(image image: String, title: String) {
    personalityImage.image = UIImage(named: image)
    titleLabel.text = title
  }
  
}
