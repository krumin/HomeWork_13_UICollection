//
//  AutoCollectionViewCell.swift
//  HomeWork_13_UICollection
//
//  Created by MAC OS  on 20.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class ModelCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var cellImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var model: CarModel? {
    didSet {
      if let model = model?.nameModel {
        nameLabel.text = model
      }
      if let model = model?.modelImageName {
        cellImageView.image = UIImage(named: model)
      } else {
        cellImageView.image = nil
      }
    }
  }
}

