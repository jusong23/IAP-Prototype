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

    @objc private func handlePurchaseNoti(_ notification: Notification) {
        guard
            let productID = notification.object as? String,
            let index = self.products.firstIndex(where: { $0.productIdentifier == productID })
            else { return }

//        self.tableView.reloadRows(at: [IndexPath(index: index)], with: .fade)
//        self.tableView.performBatchUpdates(nil, completion: nil)
    }

    // MARK: IBActions
    @IBAction func didRestore(_ sender: Any) {
        print(#function)
        MyProducts.iapService.restorePurchases()
    }

    @IBAction func didBuy(_ sender: Any) {
        print(#function)
        MyProducts.iapService.buyProduct(product!)
    }
}
