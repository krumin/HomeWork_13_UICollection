//
//  SectionHeaderView.swift
//  HomeWork_13_UICollection
//
//  Created by MAC OS  on 20.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class BrandHeaderView: UICollectionReusableView {
  
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var headerLabel: UILabel!
  
  var brand: BrandModel? {
    didSet {
      if let brand = brand?.brandName {
        headerLabel.text = brand
      }
      if let imageName = brand?.brandImageName {
        headerImageView.image = UIImage(named: imageName)
      }
      headerImageView.layer.cornerRadius = headerImageView.bounds.height / 2
      headerImageView.layer.masksToBounds = true

    }
  }
}
