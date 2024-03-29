//
//  DataManager.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

// 데이터 관리를 총괄하는 임무를 준 아이.
final class DataManager {
  // 매니저가 여러명이면 작업이 산으로 가기 때문에 데이터는 한명이 관리하도록 싱글톤
  static let shared = DataManager()
  private init() {}
  
  // 데이터 받기 위한 네트워크도 Manager를 통해서 받도록
  let service: BucketServiceType = BucketService()
  
  // 데이터 전달을 위한 노티도 Manager를 통해서 전달하도록
  let noti = NotificationCenter.default
  
  // 변하지 않는 정적인 데이터
  let sortingData: [String : [String]] = ["정렬" : ["최신순", "베스트순", "인기순"], "공간" : ["거실", "침실", "주방", "욕실"], "주거형태" : ["아파트", "빌라&연립", "단독주택", "사무공간"]]
  
  // MARK: - filter Data 부분
  var filterData: [String: String] = ["정렬" : "0", "공간" : "0", "주거형태" : "0"]
  
  // filterData 딕셔너리에 값이 존재하는 것만 모은 배열 - > FilterView의 CollectionView 를 구성할 때 사용
  var filterDataArr: [String] {
    get {
      //let dicData = DataManager.shared.filterData
      var array: [String] = []
      for value in filterData.values {
        if value != "0" {
          array.append(value)
        }
      }
      return array.sorted()
    }
  }
  
  // MARK: - Contents List Data 부분
  // 앱의 핵심 데이터이기 때문에 안정성을 높이기 위해 직접 접근 못하게 private
  private var contents: [Bucket] = []
  
  internal func getContents() -> [Bucket] {
    return contents
  }
  
  // 기존에 있던 데이터에 추가
  internal func addContents(_ contents: [Bucket]) {
    self.contents += contents
  }
  
  // 새로운 데이터로 갱신
  internal func setContents(_ contents: [Bucket]) {
    self.contents.removeAll()
    self.contents = contents
  }
  
  // 정렬별 url query문에 사용할 문자열 변환하는 Helper Method
  func convertText(_ text: String) -> String {
    switch text {
    case "최신순":
      return "recent"
    case "베스트순":
      return "best"
    case "인기순":
      return "popular"
    case "거실", "아파트":
      return "1"
    case "침실", "빌라&연립":
      return "2"
    case "주방", "단독주택":
      return "3"
    case "욕실", "사무공간":
      return "4"
    default:
      break
    }
    logger("Can't convert Text")
    return ""
  }
  
  
}
