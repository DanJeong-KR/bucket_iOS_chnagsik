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
  internal lazy var sortingView: SortingView = {
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
  
  private var isScrollIsEnd: Bool = false
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    noti()
    networkService(forScroll: false)
    makeConstrains()
  }
  
  //MARK: - Network
  private func networkService(forScroll param: Bool) {
    let filterData = DataManager.shared.filterData
    DataManager.shared.service.fetchBucketData(order: filterData["정렬"] ?? "0", space: filterData["공간"] ?? "0", residence: filterData["주거형태"] ?? "0", page: "1") { result in
      
      switch result {
      case .success(let contents):
        DispatchQueue.main.async {
          if param {
            // load more 의 경우 기존의 데이터 뒤에 추가하기.
            DataManager.shared.addContents(contents)
          }else {
            // load more 가 아닐 때는 기존의 데이터 갱신
            DataManager.shared.setContents(contents)
          }
          self.contents = DataManager.shared.getContents()
          self.contentTableView.reloadData()
        }
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
    // 필터 걸면 나타나고, 취소하면 없어지게
    filterHeight?.constant = DataManager.shared.filterDataArr.isEmpty ? 1 : 50
    
    // 필터 걸면 스크롤 가장 위로 이동시키기.
    contentTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    
    // 필터에 따라서 다른 데이터 받고 테이블 뷰에 적용하기
    networkService(forScroll: false)
    
    let filterData = DataManager.shared.filterData
    sortingView.orderButton.isSelected = filterData["정렬"] != "0" ? true : false
    sortingView.spaceButton.isSelected = filterData["공간"] != "0" ? true : false
    sortingView.residenceButton.isSelected = DataManager.shared.filterData["주거형태"] != "0" ? true : false
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
  
  // MARK: - Gesture
  private let blackColorView = UIView()
  private var contentView: UIView?
  private var contentImageView: UIImageView?
  private let newView = UIView()
  private let newLabel = UILabel()
  private let newImageView = UIImageView()
  private var beforeX: CGFloat?
  private var beforeY: CGFloat?
  internal func selectPicture(_ contentView: UIView, _ contentImageView: UIImageView, _ contentLabel: UILabel) {
    self.contentView = contentView
    self.contentImageView = contentImageView
    
    if let startingFrame = contentView.superview?.convert(contentView.frame, to: nil) {
      // 원래 이미지 안보이게
      self.contentView!.alpha = 0
      
      blackColorView.frame = self.view.frame
      blackColorView.backgroundColor = .black
      blackColorView.alpha = 0
      view.addSubview(blackColorView)
      
      
      newView.frame = startingFrame
      newView.isUserInteractionEnabled = true
      
      
      newLabel.frame = contentLabel.frame
      newLabel.text = contentLabel.text
      newLabel.numberOfLines = 5
      newLabel.lineBreakMode = .byTruncatingTail // ... 더보기
      newLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
      newLabel.font = Global.regular
      
      newImageView.frame = contentImageView.frame
      newImageView.image = contentImageView.image
      newImageView.isUserInteractionEnabled = true
      newImageView.clipsToBounds = true
      newImageView.contentMode = .scaleAspectFill
      newImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(deselectPicture)))
      newImageView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchPicture(_:))))
      
      beforeX = contentImageView.center.x
      beforeY = contentImageView.center.y
      
      newView.addSubview(newLabel)
      newView.addSubview(newImageView)
      
      self.view.addSubview(newView)
      
      UIView.animate(withDuration: 0.75) {
        let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
        let y = self.view.frame.height / 2 - height / 2
        self.newView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        
        self.blackColorView.alpha = 1
        self.newLabel.textColor = .white
      }
    }
  }
  
  @objc private func deselectPicture(_ sender: UIPanGestureRecognizer) {
    if let startingFrame = contentView!.superview?.convert(contentView!.frame, to: nil) {
      
      let transition = sender.translation(in: newImageView)
      let newX = newImageView.center.x + transition.x
      let newY = newImageView.center.y + transition.y
      newImageView.center = CGPoint(x: newX, y: newY)
      sender.setTranslation(.zero, in: newImageView)
      
      // 피타고라스 정리를 활용해서 alpha 구할 것
      let a = newX - beforeX!
      let b = newY - beforeY!
      let pita = (a * a + b * b).squareRoot()
      
      if pita < 210 {
        self.blackColorView.alpha = 1 - (pita / 700)
      } else {
        self.blackColorView.alpha = 0.7
      }
      print("alpha : ",self.blackColorView.alpha)
      
      print("state :", sender.state.rawValue )
      if sender.state.rawValue == 3 {
        if self.blackColorView.alpha < 0.71{
          UIView.animate(withDuration: 0.75, animations: {
            // 제자리로 되돌리기
            self.newView.frame = startingFrame
            self.newImageView.frame = self.contentImageView!.frame
            self.blackColorView.alpha = 0
            self.newLabel.textColor = .darkGray
          }) { _ in
            // 애니메이션을 위해 만든 것들 지워주고
            self.blackColorView.removeFromSuperview()
            self.newView.removeFromSuperview()
            self.newImageView.removeFromSuperview()
            self.contentView?.alpha = 1
          }
        }else {
          UIView.animate(withDuration: 0.75) {
            self.newImageView.center = CGPoint(x: self.beforeX!, y: self.beforeY!)
            self.blackColorView.alpha = 1
          }
        }
      }
    }
  }
  
  @objc private func pinchPicture(_ sender: UIPinchGestureRecognizer) {
    newImageView.transform = newImageView.transform.scaledBy(x: sender.scale, y: sender.scale)
    sender.scale = 1.0
    
    if sender.state.rawValue == 3 {
      UIView.animate(withDuration: 0.75) {
        self.newImageView.transform = .identity
      }
    }
  }
  
}

extension ContentListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ContentTableViewCell.self)
    cell.setContents(with: contents[indexPath.row])
    cell.contentVC = self
    return cell
  }
}

extension ContentListViewController: UITableViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offsetY > contentHeight - scrollView.frame.height {
      
      isScrollIsEnd = true
      if isScrollIsEnd {
        isScrollIsEnd = false
        networkService(forScroll: true)
      }
    }
  }
}

