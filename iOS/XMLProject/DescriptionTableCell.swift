//
//  DescriptionTableCell.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/8/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import UIKit

class DescriptionTableCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configure(title: String) {
    titleLabel.text = title
  }
}
