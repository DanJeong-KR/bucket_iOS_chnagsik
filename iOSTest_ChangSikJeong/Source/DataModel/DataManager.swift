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
  static let shared = DataManager()  // 매니저가 여러명이면 산으로 가니까 한명만 관리하도록 싱글톤
  private init() {}
  
  // 네트워크로 데이터 받는 것도 Manager를 통해서 받도록
  let service: BucketServiceType = BucketService()
  
  let sortingData: [String : [String]] = ["정렬" : ["최신순", "베스트순", "인기순"], "공간" : ["거실", "침실", "주방", "욕실"], "주거형태" : ["아파트", "빌라&연립", "단독주택", "사무공간"]]
  
  
  // MARK: - filter Data 부분
  var filterData: [String: String?] = ["정렬" : nil, "공간" : nil, "주거형태" : nil]
  
}
