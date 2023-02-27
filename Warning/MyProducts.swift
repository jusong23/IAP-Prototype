//
//  MyProducts.swift
//  ExInAppPurchase
//
//  Created by 김종권 on 2022/06/04.
//

import Foundation

// 앱스토어에서 입력한 ProductID를 가지고 있는 Warpping 타입
enum MyProducts {
  static let productID = "Jason.Warning.shopping"
  static let iapService: IAPServiceType = IAPService(productIDs: Set<String>([productID]))
  
  static func getResourceProductName(_ id: String) -> String? {
    id.components(separatedBy: ".").last
  }
}
