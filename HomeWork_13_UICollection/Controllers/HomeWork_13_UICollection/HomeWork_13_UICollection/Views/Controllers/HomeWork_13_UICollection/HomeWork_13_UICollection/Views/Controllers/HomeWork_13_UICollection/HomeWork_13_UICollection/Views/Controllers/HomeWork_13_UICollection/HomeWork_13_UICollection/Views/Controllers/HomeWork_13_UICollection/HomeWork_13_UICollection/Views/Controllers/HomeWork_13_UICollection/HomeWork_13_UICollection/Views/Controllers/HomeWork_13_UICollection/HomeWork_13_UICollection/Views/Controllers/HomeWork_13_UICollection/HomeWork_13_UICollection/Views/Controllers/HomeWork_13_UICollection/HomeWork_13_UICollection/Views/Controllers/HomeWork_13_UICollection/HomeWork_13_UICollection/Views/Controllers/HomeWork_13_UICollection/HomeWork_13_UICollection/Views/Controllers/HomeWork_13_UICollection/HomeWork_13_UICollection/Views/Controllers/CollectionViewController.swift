//
//  CollectionViewController.swift
//  HomeWork_13_UICollection
//
//  Created by MAC OS  on 20.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
  
  var brands: [BrandModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let audi = createAudi()
    brands.append(audi)
    
    let bwm = createBmw()
    brands.append(bwm)
    
    let toyota = createToyota()
    brands.append(toyota)
    
    let ford = createFord()
    brands.append(ford)
    
    let volkswagen = createVolkswagen()
    brands.append(volkswagen)
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
    collectionView.refreshControl = refresh
    
  }
  
  func createAudi() -> BrandModel {
    var audiBrand = BrandModel()
    audiBrand.brandName = "Audi"
    audiBrand.imageName = "audi.jpeg"
    var audiA6 = CarModel()
    audiA6.nameModel = "A6"
    audiA6.carImageName = "audi a6.jpeg"
    var audiA4 = CarModel()
    audiA4.nameModel = "A4"
    audiA4.carImageName = "audi a4.jpeg"
    var audiA8 = CarModel()
    audiA8.nameModel = "A8"
    audiA8.carImageName = "audi a8.jpeg"
    var audiQ7 = CarModel()
    audiQ7.nameModel = "Q7"
    audiQ7.carImageName = "audi q7.jpeg"
    var audiTt = CarModel()
    audiTt.nameModel = "TT"
    audiTt.carImageName = "audi tt.jpeg"
    
    audiBrand.models = [audiA6, audiA4, audiA8, audiQ7, audiTt]
    return audiBrand
    
  }
  func createBmw() -> BrandModel {
    var bmwBrand = BrandModel()
    bmwBrand.brandName = "BMW"
    bmwBrand.imageName = "bmw"
    var bmwM3 = CarModel()
    bmwM3.nameModel = "M3"
    bmwM3.carImageName = "bmw m3.jpeg"
    var bmwM5 = CarModel()
    bmwM5.nameModel = "M5"
    bmwM5.carImageName = "bmw m5.jpeg"
    var bmwz4 = CarModel()
    bmwz4.nameModel = "Z4"
    bmwz4.carImageName = "bmw z4.jpeg"
    var bmwI8 = CarModel()
    bmwI8.nameModel = "i8"
    bmwI8.carImageName = "bmw i8.jpeg"
    var bmwX5 = CarModel()
    bmwX5.nameModel = "X5"
    bmwX5.carImageName = "bmw x5.jpeg"
    
    bmwBrand.models = [bmwM3, bmwM5, bmwz4, bmwI8, bmwX5]
    return bmwBrand
  }
  
  func createToyota() -> BrandModel {
    var toyotaBrand = BrandModel()
    toyotaBrand.brandName = "Totota"
    toyotaBrand.imageName = "toyota.jpeg"
    var toyotaCorolla = CarModel()
    toyotaCorolla.nameModel = "Corolla"
    toyotaCorolla.carImageName = "toyota corolla.jpeg"
    var toyotaCamry = CarModel()
    toyotaCamry.nameModel = "Camry"
    toyotaCamry.carImageName = "toyota camry.jpeg"
    var toyotaSupra = CarModel()
    toyotaSupra.nameModel = "Supra"
    toyotaSupra.carImageName = "toyota supra.jpeg"
    var toyotaRav4 = CarModel()
    toyotaRav4.nameModel = "Rav4"
    toyotaRav4.carImageName = "toyota rav4.jpeg"
    var toyotaLandCruiser = CarModel()
    toyotaLandCruiser.nameModel = "Land Cruiser"
    toyotaLandCruiser.carImageName = "toyota land cruiser.jpeg"
    
    toyotaBrand.models = [toyotaCorolla, toyotaCamry, toyotaSupra, toyotaRav4, toyotaLandCruiser]
    return toyotaBrand
  }
  
  func createFord() -> BrandModel {
    var fordBrand = BrandModel()
    fordBrand.brandName = "Ford"
    fordBrand.imageName = "ford.jpeg"
    var fordMondeo = CarModel()
    fordMondeo.nameModel = "Mondeo"
    fordMondeo.carImageName = "ford mondeo.jpeg"
    var fordFocus = CarModel()
    fordFocus.nameModel = "Focus"
    fordFocus.carImageName = "ford focus.jpeg"
    var fordFiesta = CarModel()
    fordFiesta.nameModel = "Fiesta"
    fordFiesta.carImageName = "ford fiesta.jpeg"
    var fordKuga = CarModel()
    fordKuga.nameModel = "Kuga"
    fordKuga.carImageName = "ford kuga.jpeg"
    var fordMustang = CarModel()
    fordMustang.nameModel = "Mustang"
    fordMustang.carImageName = "ford mustang.jpeg"
    
    fordBrand.models = [fordMondeo, fordFocus, fordFiesta, fordKuga, fordMustang]
    return fordBrand
  }
  
  func createVolkswagen() -> BrandModel{
    var volkswagenBrand = BrandModel()
    volkswagenBrand.brandName = "Volkswagen"
    volkswagenBrand.imageName = "vw.jpeg"
    var volkswagenPassat = CarModel()
    volkswagenPassat.nameModel = "Passat"
    volkswagenPassat.carImageName = "volkswagen passat.jpeg"
    var volkswagenGolf = CarModel()
    volkswagenGolf.nameModel = "Golf"
    volkswagenGolf.carImageName = "volkswagen golf.jpeg"
    var volkswagenPolo = CarModel()
    volkswagenPolo.nameModel = "Polo"
    volkswagenPolo.carImageName = "volkswagen polo.jpeg"
    var volkswagenTransporter = CarModel()
    volkswagenTransporter.nameModel = "Transporter"
    volkswagenTransporter.carImageName = "volkswagen transporter.jpeg"
    var volkswagenTouareg = CarModel()
    volkswagenTouareg.nameModel = "Touareg"
    volkswagenTouareg.carImageName = "volkswagen touareg.jpeg"
    
    volkswagenBrand.models = [volkswagenPassat, volkswagenGolf, volkswagenPolo, volkswagenTransporter, volkswagenTouareg]
    return volkswagenBrand
  }
  
  @objc private func refreshCollection() {
    brands.shuffle()
    collectionView.reloadData()
    collectionView.refreshControl?.endRefreshing()
  }
  
  // MARK: - UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return brands.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return brands[section].models.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let reuseIdentifier = "auto"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AutoCollectionViewCell
    
    let brand = brands[indexPath.section]
    let model = brand.models[indexPath.row]
    
    cell.nameLabel.text = model.nameModel
    cell.cellImageView.image = UIImage(named: model.carImageName)
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let identifier = "header"
    if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? SectionHeaderView {
      
      view.brand = brands[indexPath.section]
      
      return view
    }
    
    return UICollectionReusableView()
  }
  
  // Method: - Запрет на перемещение в другую секцию
  
  override func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
    if originalIndexPath.section != proposedIndexPath.section {
      return originalIndexPath
    }
    return proposedIndexPath
  }
  
  // Method: - Перемещение
  
  override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    var currentBrand = brands[sourceIndexPath.section]
    currentBrand.models.swapAt(sourceIndexPath.item, destinationIndexPath.item)
    brands[sourceIndexPath.section] = currentBrand
//    print(brands)
  }
  
  @IBAction func addCars(_ sender: Any) {
    let randomBrand = brands.randomElement()!
    let randomModel = randomBrand.models.randomElement()!
    
    //let model = randomModel.copy() as! CarModel
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else { return }
    
    let destinationVC = segue.destination as! AutoViewController
    let brand = brands[indexPath.section]
    let model = brand.models[indexPath.row]
    destinationVC.brand = brand
    destinationVC.model = model
    
  }
}
//          let random = Int.random(in: 0..<brands.count)
//          var newModel = CarModel()
//          newModel.nameModel = "New Model"
//          let newElement = brands[random]
//          brands.append(newElement)


