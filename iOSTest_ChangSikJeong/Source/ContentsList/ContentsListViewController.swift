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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    makeConstrains()
  }
  
  private func makeConstrains() {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    sortingView.layout.top(equalTo: view.topAnchor, constant: statusBarHeight).leading().trailing().height(constant: 50)
    filterView.layout.top(equalTo: sortingView.bottomAnchor).leading().trailing().height(equalTo: sortingView.heightAnchor)
  }
  
  @objc private func buttonsDidTap(_ sender: UIButton) {
    
    switch sender.id {
    case ButtonID.sortingButton.id:
      print("정렬 버튼 클릭됨 ")
      showUserActionVC()
    case ButtonID.spaceButton.id:
      print("공간 버튼 클릭 됨")
    case ButtonID.residenceButton.id:
      print("주거형태 버튼 클릭 됨")
    default:
      break
    }
  }

}

extension UIViewController {
  func showUserActionVC() {
    let vc = UserActionViewController()
    vc.3 = .overCurrentContext
    self.present(vc, animated: false)
  }
}
