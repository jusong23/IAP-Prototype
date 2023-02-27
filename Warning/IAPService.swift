//
//  IAPService.swift
//  ExInAppPurchase
//
//  Created by 김종권 on 2022/06/04.
//

import StoreKit

typealias ProductsRequestCompletion = (_ success: Bool, _ products: [SKProduct]?) -> Void

protocol IAPServiceType {
    var canMakePayments: Bool { get }

    // products 항목 가져오기 (getProducts)
    func getProducts(completion: @escaping ProductsRequestCompletion)
    // product 구입하기 (buyProduct)
    func buyProduct(_ product: SKProduct)
    // 구입했는지 확인하기 (isProductPurchased)
    func isProductPurchased(_ productID: String) -> Bool
    // 구입한 목록 조회 (restorePurchased)
    func restorePurchases()
}

// StoreKit을 사용하려면 NSObject를 상속받고 IAPServiceType을 준수
final class IAPService: NSObject, IAPServiceType {
    
    // 앱스토어에서 입력한 productID들 "com.jake.sample.ExInAppPurchase.shopping"
    private let productIDs: Set<String>
    // 구매한 productID
    private var purchasedProductIDs: Set<String>
    //  앱스토어에 입력한 productID로 부가 정보 조회할때 사용하는 인스턴스
    private var productsRequest: SKProductsRequest?
    // 사용하는쪽에서 해당 클로저를 통해 실패 or 성공했을때 값을 넘겨줄 수 있는 프로퍼티 (델리게이트)
    private var productsCompletion: ProductsRequestCompletion?

    // queue를 확인하여 현재 결제가 되는지 확인
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }

    // 상품 정보를 받아서 초기화
    init(productIDs: Set<String>) {
        self.productIDs = productIDs
        self.purchasedProductIDs = productIDs
            .filter { UserDefaults.standard.bool(forKey: $0) == true }

        super.init()
        
        // IAPService에 SKPaymentQueue를 연결
        SKPaymentQueue.default().add(self)
    }
    
    // 상품 정보 조회: completion을 여기서 캡쳐해놓고 밑에 delegate에서 호출하는 형식
    func getProducts(completion: @escaping ProductsRequestCompletion) {
        self.productsRequest?.cancel()
        self.productsCompletion = completion
        self.productsRequest = SKProductsRequest(productIdentifiers: self.productIDs)
        self.productsRequest?.delegate = self
        self.productsRequest?.start()
    }
    
    func buyProduct(_ product: SKProduct) {
        SKPaymentQueue.default().add(SKPayment(product: product))
    }
    
    func isProductPurchased(_ productID: String) -> Bool {
        self.purchasedProductIDs.contains(productID)
    }
    
    func restorePurchases() {
        print(self.purchasedProductIDs)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension IAPService: SKProductsRequestDelegate {
    // didReceive
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        self.productsCompletion?(true, products)
        self.clearRequestAndHandler()

        products.forEach { print("Product ID: \($0.productIdentifier) \($0.localizedTitle) Price: \($0.price.floatValue)") }
    }

    // failed
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Erorr: \(error.localizedDescription)")
        self.productsCompletion?(false, nil)
        self.clearRequestAndHandler()
    }

    private func clearRequestAndHandler() {
        self.productsRequest = nil
        self.productsCompletion = nil
    }
}

extension IAPService: SKPaymentTransactionObserver {
    
    
    // 거래가 성공, 실패, restore된 경우 finishTransaction을 실행
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchased:
                print("completed transaction")
                self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
                SKPaymentQueue.default().finishTransaction($0)
            case .failed:
                if let transactionError = $0.error as NSError?,
                    let description = $0.error?.localizedDescription,
                    transactionError.code != SKError.paymentCancelled.rawValue {
                    print("Transaction erorr: \(description)")
                }
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                // restore된 경우(구매 완료된 것 다시 조회) 구매했던 목록으로 추가 (UserDefaults)
                print("failed transaction")
                self.deliverPurchaseNotificationFor(id: $0.original?.payment.productIdentifier)
                SKPaymentQueue.default().finishTransaction($0)
            case .deferred:
                print("deferred")
            case .purchasing:
                print("purchasing")
            default:
                print("unknown")
            }
        }
    }
    
    
    // PaymentQueue의 델리게이트 메소드에서 불리는 deliverPurchaseNotificationFor(id:) 메소드에 노티를 보내는 코드 추가 (post)
    private func deliverPurchaseNotificationFor(id: String?) {
        guard let id = id else { return }

        self.purchasedProductIDs.insert(id)
        UserDefaults.standard.set(true, forKey: id)
        NotificationCenter.default.post(
            name: .iapServicePurchaseNotification,
            object: id
        )
        
    }
}
