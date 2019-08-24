//
//  AutoViewController.swift
//  HomeWork_13_UICollection
//
//  Created by MAC OS  on 20.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class ModelViewController: UIViewController {
  
  @IBOutlet weak var autoImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
 
  var brand: BrandModel?
  var model: CarModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let brand = brand?.brandName {
      title = brand
    }
    if let model = model?.modelImageName {
      autoImage.image = UIImage(named: model)
    }
    if let model = model?.nameModel {
      nameLabel.text = model
    }
  }
  
  @IBAction func exitAction(_ sender: Any) {
 self.navigationController?.popToRootViewController(animated: true)
  
  }
  
}
