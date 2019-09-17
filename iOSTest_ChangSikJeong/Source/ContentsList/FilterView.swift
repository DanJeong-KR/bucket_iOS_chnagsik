//
//  FilterView.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FilterView: UIView {
  
  internal var filterData: [String] = [] {
    didSet {
      self.filterCollectionView.reloadData()
    }
  }
  
  private lazy var filterCollectionView: UICollectionView = {
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    makeConstraints()
    noti()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  private func makeConstraints() {
    filterCollectionView.layout.equalToSuperView()
  }
  
  private func noti() {
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.FilterCancelButtonDidTap, object: nil)
  }
  
  deinit {
    DataManager.shared.noti.removeObserver(self, name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.removeObserver(self, name: NotificationID.FilterCancelButtonDidTap, object: nil)
    
  }
  
  @objc private func notification(_ senrder: Notification) {
    
    switch senrder.name {
    case NotificationID.UserActionDidTap:
      filterData = DataManager.shared.reloadFilterData()
      
    case NotificationID.FilterCancelButtonDidTap:
      filterData = DataManager.shared.reloadFilterData()
    default:
      break
    }
  }
}

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


