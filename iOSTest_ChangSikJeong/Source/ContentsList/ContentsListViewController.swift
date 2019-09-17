//
//  ContentsListViewController.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

final class ContentsListViewController: UIViewController {
  
  private lazy var sortingView: UIView = {
    let v = SortingView(frame: .zero)
    v.orderButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    v.spaceButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    v.residenceButton.addTarget(self, action: #selector(buttonsDidTap(_:)), for: .touchUpInside)
    view.addSubview(v)
    return v
  }()
  
  private lazy var filterView: UIView = {
    let v = UIView(frame: .zero)
    v.backgroundColor = .red
    view.addSubview(v)
    return v
  }()
  
  private lazy var contentTableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.backgroundColor = .yellow
    tv.dataSource = self
    tv.delegate = self
    tv.register(cell: ContentTableViewCell.self)
    self.view.addSubview(tv)
    return tv
  }()
  
  internal var backColorFlag: Bool = false {
    didSet {
      self.view.backgroundColor = self.backColorFlag ? #colorLiteral(red: 0.601804018, green: 0.6007441878, blue: 0.6026645303, alpha: 0.5766210938) : .white
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeConstrains()
  }
  
  private func makeConstrains() {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    sortingView.layout.top(equalTo: view.topAnchor, constant: statusBarHeight).leading().trailing().height(constant: 50)
    
    filterView.layout.top(equalTo: sortingView.bottomAnchor).leading().trailing().height(equalTo: sortingView.heightAnchor)
    
    contentTableView.layout.top(equalTo: filterView.bottomAnchor).leading().trailing().bottom()
  }
  
  @objc private func buttonsDidTap(_ sender: UIButton) {
    
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

extension ContentsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension ContentsListViewController: UITableViewDelegate {
  
}

