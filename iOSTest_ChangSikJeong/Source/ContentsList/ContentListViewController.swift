//
//  ContentsListViewController.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

final class ContentListViewController: UIViewController {
  
  // MARK: - Properties
  private lazy var sortingView: SortingView = {
    let v = SortingView(frame: .zero)
    v.orderButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    v.spaceButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    v.residenceButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    view.addSubview(v)
    return v
  }()
  
  private lazy var filterView: FilterView = {
    let v = FilterView(frame: .zero)
    v.backgroundColor = .red
    view.addSubview(v)
    return v
  }()
  
  private lazy var contentTableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.dataSource = self
    tv.delegate = self
    tv.register(cell: ContentTableViewCell.self)
    tv.estimatedRowHeight = 200
    tv.rowHeight = UITableView.automaticDimension
    tv.separatorStyle = .none
    self.view.addSubview(tv)
    return tv
  }()
  
  private lazy var backColorView: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .clear
    self.view.addSubview(v)
    self.view.insertSubview(v, at: 0)
    return v
  }()
  
  // 배경 결정하는 흐림의 정도를 결정하는 변수
  internal var backColorFlag: Bool = false {
    didSet {
      if self.backColorFlag {
        self.backColorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6024843751)
      } else {
        self.backColorView.backgroundColor = .clear
        self.view.insertSubview(backColorView, at: 0)
      }
      
    }
  }
  
  private var contents: [Bucket] = []
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    noti()
    networkService()
    makeConstrains()
  }
  
  //MARK: - Network
  private func networkService() {
    DataManager.shared.service.fetchBucketData(order: nil, space: nil, residence: nil) { result in
      switch result {
      case .success(let contents):
        self.contents = contents
      case .failure(let error):
        logger(error.localizedDescription)
      }
    }
  }
  
  //MARK: - Layouts
  var filterHeight: NSLayoutConstraint?
  
  private func makeConstrains() {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    sortingView.layout.top(equalTo: view.topAnchor, constant: statusBarHeight).leading().trailing().height(constant: 50)
    
    filterView.layout.top(equalTo: sortingView.bottomAnchor).leading().trailing()
    filterHeight = filterView.heightAnchor.constraint(equalToConstant: 1)
    filterHeight?.isActive = true
    
    contentTableView.layout.top(equalTo: filterView.bottomAnchor).leading().trailing().bottom()
    
    backColorView.layout.equalToSuperView()
  }
  
  //MARK: - Notification
  private func noti() {
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.addObserver(self, selector: #selector(notification(_:)), name: NotificationID.FilterCancelButtonDidTap, object: nil)
  }
  
  deinit {
    DataManager.shared.noti.removeObserver(self, name: NotificationID.UserActionDidTap, object: nil)
    DataManager.shared.noti.removeObserver(self, name: NotificationID.FilterCancelButtonDidTap, object: nil)
  }
  
  @objc private func notification(_ sender: Notification) {
    filterHeight?.constant = DataManager.shared.filterDataArr.isEmpty ? 1 : 50
    
    print("filterData :",DataManager.shared.filterData)
    
//    if let _ = DataManager.shared.filterData["정렬"] {
//      sortingView.orderButton.isSelected = true
//    } else {
//      sortingView.orderButton.isSelected = false
//    }
//    if let _ = DataManager.shared.filterData["공간"] {
//      sortingView.spaceButton.isSelected = true
//    } else {
//      sortingView.spaceButton.isSelected = false
//    }
//    if let _ = DataManager.shared.filterData["주거형태"] {
//      sortingView.residenceButton.isSelected = true
//    } else {
//      sortingView.residenceButton.isSelected = false
//    }
    //FIXME: - 왜 전부 true 되는지 모르겠네 버근가
//    let filterData = DataManager.shared.filterData
//    sortingView.orderButton.isSelected = filterData["정렬"] != nil ? true : false
//    sortingView.spaceButton.isSelected = filterData["공간"] != nil ? true : false
//    sortingView.residenceButton.isSelected = DataManager.shared.filterData["주거형태"] == nil ? false : true
    
//    print("order Button : ", sortingView.orderButton.isSelected)
//    print("space Button : ", sortingView.spaceButton.isSelected)
//    print("resi Button : ", sortingView.residenceButton.isSelected)
  }
  
  //MARK: - Action Methods
  @objc private func buttonsDidTap(_ sender: UIButton) {
    
    self.view.bringSubviewToFront(self.backColorView)
    
    switch sender.id {
    case ButtonID.sortingButton.id:
      print("정렬 버튼 클릭됨 ")
      showUserActionVC(withName: "정렬",
                       withData: DataManager.shared.sortingData["정렬"] ?? ["Dic Error"])
    case ButtonID.spaceButton.id:
      print("공간 버튼 클릭 됨")
      showUserActionVC(withName: "공간",
                       withData: DataManager.shared.sortingData["공간"] ?? ["Dic Error"])
    case ButtonID.residenceButton.id:
      print("주거형태 버튼 클릭 됨")
      showUserActionVC(withName: "주거형태",
                       withData: DataManager.shared.sortingData["주거형태"] ?? ["Dic Error"])
    default:
      break
    }
  }
  
  private func showUserActionVC(withName sortingName: String, withData sortingData: [String]) {
    let vc = UserActionViewController(sortingName, sortingData)
    vc.modalPresentationStyle = .overCurrentContext
    self.backColorFlag = true
    self.present(vc, animated: true)
  }
  
}

extension ContentListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ContentTableViewCell.self)
    cell.setContents(with: contents[indexPath.row])
    return cell
  }
}

extension ContentListViewController: UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let test = (scrollView.contentOffset.y % 7500)
    print("scroll y : ",scrollView.contentOffset, " test : ", test)
    
  }
}

