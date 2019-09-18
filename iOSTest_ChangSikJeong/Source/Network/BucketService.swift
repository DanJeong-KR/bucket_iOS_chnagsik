//
//  Network.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

final class BucketService: BucketServiceType {
  
  private let baseURL = "https://s3.ap-northeast-2.amazonaws.com"
  
  // 테스트 성공 commit
  func fetchBucketData(order: String, space: String, residence: String, page: String, completionHandler: @escaping (Result<[Bucket], ServiceError>) -> Void) {
    
    var urlComponent = URLComponents(string: baseURL)
    urlComponent?.path = "/bucketplace-coding-test/cards/page_" + page + ".json"
    urlComponent?.queryItems = []
    
    // 매개변수에 따라 동적으로 url을 재작성하도록
    for (a, b) in zip(["order", "space", "residence"], [order, space, residence]) {
      if b != "0" {
        
        urlComponent!.queryItems!.append(URLQueryItem(name: a, value: DataManager.shared.convertText(b)))
      }
    }
    
    guard let url = urlComponent?.url else {
      return logger(ErrorLog.unwrap)
    }
    
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      
      guard error == nil else {
        logger(ServiceError.clientError.localizedDescription)
        return completionHandler(.failure(.clientError))
      }
      guard let header = response as? HTTPURLResponse,
        (200..<300) ~= header.statusCode else {
          logger(ServiceError.invalidStatusCode.localizedDescription)
          return completionHandler(.failure(.invalidStatusCode))
      }
      guard let data = data else {
        logger(ServiceError.noData.localizedDescription)
        return completionHandler(.failure(.noData))
      }
      
      // JSON Parsing
      if let bucket = try? JSONDecoder().decode([Bucket].self, from: data) {
        logger("Networking is Success")
        logger("재 정렬된 데이터가 변하지 않아서 url을 log로 남깁니다. \(url)")
        completionHandler(.success(bucket))
      } else {
        completionHandler(.failure(.invalidFormat))
      }
    }
    task.resume()
    
  }
}

