//
//  IAPViewController.swift
//  Warning
//
//  Created by mobile on 2023/02/17.
//

import UIKit
import StoreKit

class IAPViewController: UIViewController {

    private var products = [SKProduct]()
    private var product: SKProduct?

    //MARK: Outlets
    @IBOutlet weak var restoreLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // products 항목 가져오기
        MyProducts.iapService.getProducts { [weak self] success, products in
            print("load products \(products ?? [])")
            guard let vc = self else { return }
            if success, let products = products {
                DispatchQueue.main.async {
                    vc.products = products
                    vc.product = products.first
                }
            }
        }

        // 사용하는 쪽 ViewController에서 노티 구독
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePurchaseNoti(_:)),
            name: .iapServicePurchaseNotification,
            object: nil
        )
    }

    func successAction() {
        let successMesage = UIAlertController(title: "결제 성공", message: "구매가 완료되었습니다.", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("확인")
        })
        successMesage.addAction(confirmAction)
        self.present(successMesage, animated: true, completion: nil)
    }

    @objc private func handlePurchaseNoti(_ notification: Notification) {
        guard
            let productID = notification.object as? String,
            let index = self.products.firstIndex(where: { $0.productIdentifier == productID })
            else { return }
    }

    // MARK: IBActions
    @IBAction func didRestore(_ sender: Any) {
        print(#function)
        MyProducts.iapService.restorePurchases()
        // restore된 경우(과거 구매 완료된 것 다시 조회) 구매했던 목록으로 추가 (UserDefaults) - 서버에 전달
    }

    @IBAction func didBuy(_ sender: Any) {
        print(#function)
        MyProducts.iapService.buyProduct(product!)
    }
}
