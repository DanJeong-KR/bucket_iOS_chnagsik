//
//  UserActionViewController.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class UserActionViewController: UIViewController {
  
  
  internal var sortingName = ""
  internal var sortingData: [String] = []
  
  // MARK: - Properties
  private lazy var clearView: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .clear
    self.view.addSubview(v)
    return v
  }()
  
  private lazy var titleView: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .white
    self.view.addSubview(v)
    return v
  }()
  
  internal lazy var titleLabel: UILabel = {
    let lb = UILabel(frame: .zero)
    lb.text = "..."
    lb.font = Global.regular
    self.titleView.addSubview(lb)
    return lb
  }()
  
  private lazy var initButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("초기화", for: .normal)
    bt.titleLabel?.font = Global.regular
    bt.setTitleColor(Global.mainColor, for: .normal)
    bt.addTarget(self, action: #selector(initButtonDIdTap(_:)), for: .touchUpInside)
    self.titleView.addSubview(bt)
    return bt
  }()
  
  private lazy var actionTableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.tableFooterView = UIView()
    tv.dataSource = self
    tv.delegate = self
    tv.register(cell: UITableViewCell.self)
    tv.backgroundColor = .white
    self.view.addSubview(tv)
    return tv
  }()
  
  // MARK: - Initializers
  init(_ sortingName: String, _ sortingData: [String]) {
    super.init(nibName: nil, bundle: nil)
    self.sortingName = sortingName
    self.sortingData = sortingData
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.titleLabel.text = sortingName
    
    makeConstraints()
    view.backgroundColor = .clear
  }
  
  // MARK: - Layout Methods
  private func makeConstraints() {
    clearView.layout.top().leading().trailing().height(constant: 300)
    
    titleView.layout.top(equalTo: clearView.bottomAnchor).leading().trailing().height(constant: 60)
    titleLabel.layout.top(constant: 5).centerX()
    initButton.layout.top().trailing(constant: -10)
    
    actionTableView.layout.bottom().leading().trailing().top(equalTo: titleView.bottomAnchor)
  }
  
  // MARK: - Action Methods
  @objc private func initButtonDIdTap(_ sender: Any) {
    // 초기화 버튼 로직
    if let _ = DataManager.shared.filterData[sortingName] {
      DataManager.shared.filterData[sortingName] = nil
    }
  }
}

extension UserActionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sortingData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(UITableViewCell.self)
    cell.textLabel?.text = sortingData[indexPath.row]
    cell.textLabel?.font = Global.thin
    return cell
  }
}

extension UserActionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // 화면 내려가기
    let contentListVC = (self.presentingViewController as! ContentListViewController)
    contentListVC.backColorFlag = false
    self.dismiss(animated: true)
    
    DataManager.shared.filterData[sortingName] = sortingData[indexPath.row]
    
    // FilterView가 이벤트를 감지하기 위한 노티
    DataManager.shared.noti.post(name: NotificationID.UserActionDidTap, object: nil)
    
  }
}
