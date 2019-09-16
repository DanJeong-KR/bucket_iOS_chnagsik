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
  }
  
  @objc private func buttonsDidTap(_ sender: UIButton) {
    
    switch sender.id {
    case ButtonID.sortingButton.id:
      print("정렬 버튼 클릭됨 ")
      showUserActionVC(withName: "정렬", withData: ["최신순", "베스트순", "인기순"])
    case ButtonID.spaceButton.id:
      print("공간 버튼 클릭 됨")
      showUserActionVC(withName: "공간", withData: ["거실", "침실", "주방", "욕실"])
    case ButtonID.residenceButton.id:
      print("주거형태 버튼 클릭 됨")
      showUserActionVC(withName: "주거형태", withData: ["아파트", "빌라&연립", "단독주택", "사무공간"])
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

//extension UIViewController {
//  func showUserActionVC(withName sortingName: String, withData sortingData: [String]) {
//    let vc = UserActionViewController(sortingName, sortingData)
//    vc.modalPresentationStyle = .overCurrentContext
//    self.present(vc, animated: true)
//  }
//}
