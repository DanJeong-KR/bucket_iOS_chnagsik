//
//  UserActionViewController.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class UserActionViewController: UIViewController {
  
  // MARK: - Data Properties
  internal var sortingName = ""
  internal var sortingData: [String] = []
  
  private var contentListVC: ContentListViewController?
  
  // MARK: - Properties
  private lazy var clearView: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .clear
    v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearViewDidTap(_:))))
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
    lb.font = Global.heavy
    self.titleView.addSubview(lb)
    return lb
  }()
  
  private lazy var initButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("초기화", for: .normal)
    bt.setTitleColor(.white, for: .selected)
    bt.titleLabel?.font = Global.heavy
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
    contentListVC = (self.presentingViewController as! ContentListViewController)
    initButton.isHidden = DataManager.shared.filterData[sortingName] == "0" ? true : false
    makeConstraints()
    view.backgroundColor = .clear
  }
  
  // MARK: - Layout Methods
  private func makeConstraints() {
    let deviceOri = UIDevice.current.orientation.rawValue
    if deviceOri == 1 || deviceOri == 0 || deviceOri == 5 { // 세로방향이면
      clearView.layout.top().leading().trailing().height(constant: 300)
    } else { // 가로
      clearView.layout.top().leading().trailing().height(constant: 100)
    }
    
    titleView.layout.top(equalTo: clearView.bottomAnchor).leading().trailing().height(constant: 60)
    titleLabel.layout.top(constant: 5).centerX()
    initButton.layout.top().trailing(constant: -10)
    
    actionTableView.layout.bottom().leading().trailing().top(equalTo: titleView.bottomAnchor)
  }
  
  // 초기화 버튼이나 정렬 카테고리 클릭했을 때
  private func userActionDidTap(with contentListVC: ContentListViewController?, isNeedNoti noti: Bool) {
    
    guard let contentListVC = contentListVC else { return logger(ErrorLog.unwrap)}
    
    contentListVC.backColorFlag = false
    self.dismiss(animated: true)
    
    // FilterView가 이벤트를 감지하기 위한 노티
    if noti {
      DataManager.shared.noti.post(name: NotificationID.UserActionDidTap, object: nil)
    }
  }
  
  // MARK: - Action Methods
  @objc private func initButtonDIdTap(_ sender: Any) {
    // 초기화 버튼 로직
    DataManager.shared.filterData[sortingName] = "0"
    userActionDidTap(with: contentListVC, isNeedNoti: true)
  }
  
  @objc private func clearViewDidTap(_ sender: UITapGestureRecognizer) {
    // 단순 dismiss 이기에 다른 객체에 이벤트 전달하지 않는다
    userActionDidTap(with: contentListVC, isNeedNoti: false)
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
    
    DataManager.shared.filterData[sortingName] = sortingData[indexPath.row]
    
    userActionDidTap(with: contentListVC, isNeedNoti: true)
  }
}
