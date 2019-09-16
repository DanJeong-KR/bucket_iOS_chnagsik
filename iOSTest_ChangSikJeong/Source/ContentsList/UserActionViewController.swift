//
//  UserActionViewController.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class UserActionViewController: UIViewController {
  
//  private lazy var clearView: UIView = {
//    let v = UIView(frame: .zero)
//    v.backgroundColor = .yellow
//    v.alpha = 0.5
//    self.view.addSubview(v)
//    return v
//  }()
  
  private lazy var label: UILabel = {
    let lb = UILabel(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    lb.backgroundColor = .yellow
    self.view.addSubview(lb)
    return lb
  }()
  
  private lazy var actionTableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.dataSource = self
    tv.register(cell: UITableViewCell.self)
    tv.backgroundColor = .white
    self.view.addSubview(tv)
    return tv
  }()
  
  private lazy var titleLabel: UILabel = {
    let lb = UILabel(frame: .zero)
    lb.text = "Test"
    self.view.addSubview(lb)
    return lb
  }()
  
  private lazy var initButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("초기화", for: .normal)
    bt.setTitleColor(Global.mainColor, for: .normal)
    self.view.addSubview(bt)
    return bt
  }()
  
  internal var sortingName = "정렬"
  internal var sortingData: [String] = ["최신순", "베스트순", "인기순"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.alpha = 0.5
    //makeConstraints()
    view.backgroundColor = .red
  }
  
  private func makeConstraints() {
//    titleLabel.layout.top().centerX()
//    initButton.layout.top().trailing()
    actionTableView.bottom().leading().trailing().top(equalTo: self.view.topAnchor, constant: -150)
  }
}

extension UserActionViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sortingData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(UITableViewCell.self)
    cell.textLabel?.text = sortingData[indexPath.row]
    return cell
  }
  
  
}
