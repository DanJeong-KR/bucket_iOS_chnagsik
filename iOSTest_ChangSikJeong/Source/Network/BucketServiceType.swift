//
//  NetworkType.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import Foundation

protocol BucketServiceType {
  
  func fetchBucketData(
    order: String?,
    space: String?,
    residence: String?,
    completionHandler: @escaping (Result<[Bucket], ServiceError>) -> Void
  )
  
}
