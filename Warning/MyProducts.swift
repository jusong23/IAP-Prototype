//
//  MyProducts.swift
//  ExInAppPurchase
//
//  Created by 김종권 on 2022/06/04.
//

import Foundation

// 앱스토어에서 입력한 ProductID를 가지고 있는 Warpping 타입
enum MyProducts {
//    static let productID_1 = "Jason.Warning.product_1"
//    static let productID_2 = "Jason.Warning.product_2"
//    static let productID_3 = "Jason.Warning.product_3"

    static let iapService: IAPServiceType = IAPService(productIDs: ["Jason.Warning.product_1", "Jason.Warning.product_2", "Jason.Warning.product_3", "AnnualSubsription","test_1500","MonthlySubsription"])

    static func getResourceProductName(_ id: String) -> String? {
        id.components(separatedBy: ".").last
    }
}

// 개수문제 해결^^ㄱ
