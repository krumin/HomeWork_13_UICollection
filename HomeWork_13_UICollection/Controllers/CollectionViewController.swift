//
//  CollectionViewController.swift
//  HomeWork_13_UICollection
//
//  Created by MAC OS  on 20.08.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  // Сколько ячеек в строке
  let numberItemsInRow = 3
  
  // Глобальная переменная
  var brands: [BrandModel] = []
  
  // Счетчик
  var counter = 0 {
    didSet {
      createCounterBarButtonItem()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    createCounterBarButtonItem()
    
    // Add to array [BrandModel]
    createBrands()
    
    // Setup collection view layout
    setupCollectionViewLayout()
    
    // Create UIRefreshControl
    setupRefreshControl()
  }
  
  func createBrands() {
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
  }
  
  // Настройка Layout для ячеек
  
  func setupCollectionViewLayout() {
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.minimumInteritemSpacing = 10
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.sectionHeadersPinToVisibleBounds = true
  }
  
  // Method for refreshCollection
  
  func setupRefreshControl() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
    collectionView.refreshControl = refresh
  }
  
  @objc private func refreshCollection() {
    brands.shuffle()
    collectionView.reloadData()
    collectionView.refreshControl?.endRefreshing()
  }
  
  // Метод для счета из BarButtonItem
  
  func createCounterBarButtonItem() {
    if let items = navigationItem.rightBarButtonItems {
      var cleanItems = items.filter { $0.tag != 99 }
      let counterItem = UIBarButtonItem(title: "\(counter)", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
      counterItem.tag = 99
      cleanItems.append(counterItem)
      self.navigationItem.rightBarButtonItems = cleanItems
    }
  }
  
  // MARK: - UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    
    return brands.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return brands[section].models.count
  }
  
  // Create cell
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let reuseIdentifier = "auto"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ModelCollectionViewCell
    
    let brand = brands[indexPath.section]
    let model = brand.models[indexPath.row]
    
    cell.nameLabel.text = model.nameModel
    cell.cellImageView.image = UIImage(named: model.modelImageName)
    
    return cell
  }
  
  // Create header
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let identifier = "header"
    if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? BrandHeaderView {
      
      view.brand = brands[indexPath.section]
      
      return view
    }
    
    return UICollectionReusableView()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  // Расстояние между ячейками
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthScreen = collectionView.bounds.width
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let sectionHorizontalOffset = layout.sectionInset.left + layout.sectionInset.right
    let interitemSpacing = layout.minimumInteritemSpacing * CGFloat(numberItemsInRow - 1)
    let itemSide = Float((widthScreen - sectionHorizontalOffset - interitemSpacing) / CGFloat(numberItemsInRow))
    // Округление в меньшую сторону
    let floorValue = CGFloat(floorf(itemSide))
    return CGSize(width: floorValue, height: floorValue)
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
  
  // Method add random cars
  
  @IBAction func addCars(_ sender: Any) {
    counter += 1
    let randomBrand = brands.randomElement()!
    let randomModel = randomBrand.models.randomElement()!
    let newModel = CarModel(nameModel: "New Model", modelImageName: randomModel.modelImageName)
    let randomIndex = Int.random(in: 0..<brands.count)
    var brand = brands[randomIndex]
    brand.models.append(newModel)
    brands[randomIndex] = brand
    collectionView.insertItems(at: [IndexPath(item: brands[randomIndex].models.count - 1, section: randomIndex)])
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else { return }
    
    let destinationVC = segue.destination as! ModelViewController
    let brand = brands[indexPath.section]
    let model = brand.models[indexPath.row]
    destinationVC.brand = brand
    destinationVC.model = model
    
  }
}

// Method: - Create brand and model

extension CollectionViewController {
  
  func createAudi() -> BrandModel {
    var audiBrand = BrandModel()
    audiBrand.brandName = "Audi"
    audiBrand.brandImageName = "audi.jpeg"
    var audiA6 = CarModel()
    audiA6.nameModel = "A6"
    audiA6.modelImageName = "audi a6.jpeg"
    var audiA4 = CarModel()
    audiA4.nameModel = "A4"
    audiA4.modelImageName = "audi a4.jpeg"
    var audiA8 = CarModel()
    audiA8.nameModel = "A8"
    audiA8.modelImageName = "audi a8.jpeg"
    var audiQ7 = CarModel()
    audiQ7.nameModel = "Q7"
    audiQ7.modelImageName = "audi q7.jpeg"
    var audiTt = CarModel()
    audiTt.nameModel = "TT"
    audiTt.modelImageName = "audi tt.jpeg"
    
    audiBrand.models = [audiA6, audiA4, audiA8, audiQ7, audiTt]
    return audiBrand
    
  }
  func createBmw() -> BrandModel {
    var bmwBrand = BrandModel()
    bmwBrand.brandName = "BMW"
    bmwBrand.brandImageName = "bmw"
    var bmwM3 = CarModel()
    bmwM3.nameModel = "M3"
    bmwM3.modelImageName = "bmw m3.jpeg"
    var bmwM5 = CarModel()
    bmwM5.nameModel = "M5"
    bmwM5.modelImageName = "bmw m5.jpeg"
    var bmwz4 = CarModel()
    bmwz4.nameModel = "Z4"
    bmwz4.modelImageName = "bmw z4.jpeg"
    var bmwI8 = CarModel()
    bmwI8.nameModel = "i8"
    bmwI8.modelImageName = "bmw i8.jpeg"
    var bmwX5 = CarModel()
    bmwX5.nameModel = "X5"
    bmwX5.modelImageName = "bmw x5.jpeg"
    
    bmwBrand.models = [bmwM3, bmwM5, bmwz4, bmwI8, bmwX5]
    return bmwBrand
  }
  
  func createToyota() -> BrandModel {
    var toyotaBrand = BrandModel()
    toyotaBrand.brandName = "Totota"
    toyotaBrand.brandImageName = "toyota.jpeg"
    var toyotaCorolla = CarModel()
    toyotaCorolla.nameModel = "Corolla"
    toyotaCorolla.modelImageName = "toyota corolla.jpeg"
    var toyotaCamry = CarModel()
    toyotaCamry.nameModel = "Camry"
    toyotaCamry.modelImageName = "toyota camry.jpeg"
    var toyotaSupra = CarModel()
    toyotaSupra.nameModel = "Supra"
    toyotaSupra.modelImageName = "toyota supra.jpeg"
    var toyotaRav4 = CarModel()
    toyotaRav4.nameModel = "Rav4"
    toyotaRav4.modelImageName = "toyota rav4.jpeg"
    var toyotaLandCruiser = CarModel()
    toyotaLandCruiser.nameModel = "Land Cruiser"
    toyotaLandCruiser.modelImageName = "toyota land cruiser.jpeg"
    
    toyotaBrand.models = [toyotaCorolla, toyotaCamry, toyotaSupra, toyotaRav4, toyotaLandCruiser]
    return toyotaBrand
  }
  
  func createFord() -> BrandModel {
    var fordBrand = BrandModel()
    fordBrand.brandName = "Ford"
    fordBrand.brandImageName = "ford.jpeg"
    var fordMondeo = CarModel()
    fordMondeo.nameModel = "Mondeo"
    fordMondeo.modelImageName = "ford mondeo.jpeg"
    var fordFocus = CarModel()
    fordFocus.nameModel = "Focus"
    fordFocus.modelImageName = "ford focus.jpeg"
    var fordFiesta = CarModel()
    fordFiesta.nameModel = "Fiesta"
    fordFiesta.modelImageName = "ford fiesta.jpeg"
    var fordKuga = CarModel()
    fordKuga.nameModel = "Kuga"
    fordKuga.modelImageName = "ford kuga.jpeg"
    var fordMustang = CarModel()
    fordMustang.nameModel = "Mustang"
    fordMustang.modelImageName = "ford mustang.jpeg"
    
    fordBrand.models = [fordMondeo, fordFocus, fordFiesta, fordKuga, fordMustang]
    return fordBrand
  }
  
  func createVolkswagen() -> BrandModel {
    var volkswagenBrand = BrandModel()
    volkswagenBrand.brandName = "Volkswagen"
    volkswagenBrand.brandImageName = "vw.jpeg"
    var volkswagenPassat = CarModel()
    volkswagenPassat.nameModel = "Passat"
    volkswagenPassat.modelImageName = "volkswagen passat.jpeg"
    var volkswagenGolf = CarModel()
    volkswagenGolf.nameModel = "Golf"
    volkswagenGolf.modelImageName = "volkswagen golf.jpeg"
    var volkswagenPolo = CarModel()
    volkswagenPolo.nameModel = "Polo"
    volkswagenPolo.modelImageName = "volkswagen polo.jpeg"
    var volkswagenTransporter = CarModel()
    volkswagenTransporter.nameModel = "Transporter"
    volkswagenTransporter.modelImageName = "volkswagen transporter.jpeg"
    var volkswagenTouareg = CarModel()
    volkswagenTouareg.nameModel = "Touareg"
    volkswagenTouareg.modelImageName = "volkswagen touareg.jpeg"
    
    volkswagenBrand.models = [volkswagenPassat, volkswagenGolf, volkswagenPolo, volkswagenTransporter, volkswagenTouareg]
    return volkswagenBrand
  }
}
