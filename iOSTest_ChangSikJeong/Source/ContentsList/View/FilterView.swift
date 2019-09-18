//
//  FilterView.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FilterView: UIView {
  
  // MARK: - Data Properties
  internal var filterData: [String] = []
  
  // MARK: - Properties
  internal lazy var filterCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(cell: FilterCollectionCell.self)
    cv.dataSource = self
    cv.delegate = self
    cv.showsHorizontalScrollIndicator = false
    cv.isScrollEnabled = false
    cv.backgroundColor = .white
    
    addSubview(cv)
    
    return cv
  }()

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    makeConstraints()
    noti()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  // MARK: - Layout Methods
  private func makeConstraints() {
    filterCollectionView.layout.equalToSuperView()
  }
  
  // MARKL - Notification
  private func noti() {
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.FilterCancelButtonDidTap, object: nil)
  }
  
  deinit {
    DataManager.shared.noti.removeObserver(self, name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.removeObserver(self, name: NotificationID.FilterCancelButtonDidTap, object: nil)
    
  }
  
  @objc private func notification(_ senrder: Notification) {
    filterData = DataManager.shared.filterDataArr
    
    UIView.animate(withDuration: 0.4) {
      self.filterCollectionView.reloadData()
      self.filterCollectionView.layoutIfNeeded()
    }
    //self.filterCollectionView.reloadData()
  }
}

// MARK: - CollectionView DataSource
extension FilterView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filterData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeue(FilterCollectionCell.self, indexPath)
    cell.setFilterCell(with: filterData[indexPath.item])
    return cell
  }
  
  
}

// MARK: - Collection FlowLayout and Delegate
extension FilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let text = filterData[indexPath.item]
    
    switch text.count {
    case 2:
      return CGSize(width: 80, height: self.frame.height)
    case 3:
      return CGSize(width: 100, height: self.frame.height)
    case 4:
      return CGSize(width: 110, height: self.frame.height)
    case 5:
      return CGSize(width: 120, height: self.frame.height)
    default:
      break
    }
    return CGSize(width: 60, height: self.frame.height)
  }
}


