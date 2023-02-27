//
//  ViewController.swift
//  Warning
//
//  Created by 이주송 on 2022/09/19.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var PostReserve = postReserve ()
//    var GetUsedSheet = getUsedSheet ()
//    var GetReserve = getReserve ()
    var PostMultiReserve = postMultiReserve ()
    
    var maxResereveIsTwo = 0

    var roomNumber:Int = 0
    
    var usedSheet:[Int] = []
        
    var checkingMultiful = 0
    
    var roomNum_1st:Int = 0
    var sheetNum_1st:Int = 0
    
    @IBOutlet weak var webView: WKWebView!
    
    var roomName: String?
    var webSiteUrl: String?
    var reservedSheetNumber: String?
    var configureUserToken:String?
    
    var MultipleDataModel = MultipleModel ()
    
    func checkingModel() {
        for i in 0..<self.MultipleDataModel.count {
            print("checkingModel")
//            print(self.MultipleDataModel.printData()[i])
        }
        print("전체 배열 확인")
        self.MultipleDataModel.printData()
    }
    
    // 다중 예약 작업을 위한 처리
//    func getReserveDetail() {
//        self.GetReserve.getReserve(token: UserDevice.Token ?? "" , onCompleted: {
//            [weak self] result in // 순환 참조 방지, 전달인자로 result
//            guard let self = self else { return } // 일시적으로 strong ref가 되게
//     
//            switch result {
//            case let .success(result):
//
//                var cellCount = result.data.data.count ?? 0
//                
//                print(result)
//                
//                
//                if result.data.data.count > 0 {
//                    print("\(result.data.data[0].roomNum)열람실 \(result.data.data[0].sheetNum)번이 예약되어 있습니다.")
//                    print("다중 예약 가능")
//                    // 이전꺼를 다중 모델에 넣는 작업
//                    for i in 0..<result.data.data.count {
//                        self.roomNum_1st = result.data.data[i].roomNum
//                        self.sheetNum_1st = result.data.data[i].sheetNum
//                        
//                        
//                        self.MultipleDataModel.inputData(room: self.roomNum_1st, sheet_num: self.sheetNum_1st)
//
//
//                    }
//
//                    self.checkingMultiful = 1
//                }
//                
//            case let .failure(error):
//                print("비어있음")
//                print("최초 예약 가능")
//                self.checkingMultiful = 0
//                LimitReserve.Number = 0
//                UserDefaults.standard.set(LimitReserve.Number, forKey: "Limit")
//            }
//        })
//    }
    
    func pleaseInputUsedSheet() {
        let alert = UIAlertController(title: "주의", message: "비워진 자석은 예약하실 수 없습니다.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .destructive) { (cancel) in }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Main Function
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {

        if UserDefaults.standard.integer(forKey: "Limit") < 2 {
            let alert = UIAlertController(title: "자리 예약하기", message: "알림 받으실 자리를 입력해주세요 ex.35", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { textField in
                textField.keyboardType = .numberPad
                textField.isFirstResponder
            })
            
            let cancel = UIAlertAction(title: "돌아가기", style: .cancel) { (cancel) in
            }
            alert.addAction(cancel)
            
            let ok = UIAlertAction(title: "예약하기", style: .default) { (ok) in
                var inputNumber = Int(alert.textFields?[0].text ?? "" ) ?? 0
                
                if self.roomName == "제 1열람실" {
                    if inputNumber >= 1 && inputNumber <= 122 {
                        
                        ReserveRoom.Num = 1
                        ReserveSheet.Num = Int(alert.textFields?[0].text ?? "" )
                        
                        if self.checkingMultiful == 0 {
                            if self.usedSheet.contains(inputNumber) == false {
                                self.pleaseInputUsedSheet()
                            } else {
                                self.PostReserve.reserve(token: UserDevice.Token ?? "", roomNum: ReserveRoom.Num ?? 0 , sheetNum: ReserveSheet.Num ?? 0)
                            }
                        } else {
                            print("다중예약메소드")
                            
                            self.MultipleDataModel.inputData(room: ReserveRoom.Num ?? 0, sheet_num: ReserveSheet.Num ?? 0)
                            
                            print(self.MultipleDataModel.count)
                            
                            for i in 0..<self.MultipleDataModel.count {
                                //                            print(self.MultipleDataModel.printData()[i])
                            }
                            
                            print("오마이갓 !!")
                            print(self.MultipleDataModel.printData())
                            
                            self.PostMultiReserve.reserve(token: UserDevice.Token ?? "", data: self.MultipleDataModel.printData() as! Array<Any>)
                            
                        }
                        LimitReserve.Number += 1
                        UserDefaults.standard.set(LimitReserve.Number, forKey: "Limit")
                        self.reserveConfirm()
                    } else {
                        self.pleaseCheckSheetNumber()
                    }
                }
                
                if self.roomName == "제 2열람실" {
                    if inputNumber >= 1 && inputNumber <= 211 {
                        
                        ReserveRoom.Num = 2
                        ReserveSheet.Num = Int(alert.textFields?[0].text ?? "" )
                        
                        if self.checkingMultiful == 0 {
                            if self.usedSheet.contains(inputNumber) == false {
                                self.pleaseInputUsedSheet()
                            } else {
                                self.PostReserve.reserve(token: UserDevice.Token ?? "", roomNum: ReserveRoom.Num ?? 0 , sheetNum: ReserveSheet.Num ?? 0)
                            }
                        } else {
                            print("다중예약메소드")
                            
                            self.MultipleDataModel.inputData(room: ReserveRoom.Num ?? 0, sheet_num: ReserveSheet.Num ?? 0)
                            
                            print(self.MultipleDataModel.count)
                            
                            for i in 0..<self.MultipleDataModel.count {
                                //                            print(self.MultipleDataModel.printData()[i])
                            }
                            
                            print("오마이갓 !!")
                            print(self.MultipleDataModel.printData())
                            
                            self.PostMultiReserve.reserve(token: UserDevice.Token ?? "", data: self.MultipleDataModel.printData() as! Array<Any>)
                            
                        }
                        LimitReserve.Number += 1
                        UserDefaults.standard.set(LimitReserve.Number, forKey: "Limit")
                        self.reserveConfirm()
                    } else {
                        self.pleaseCheckSheetNumber()
                    }
                }
                
                if self.roomName == "제 3열람실" {
                    if inputNumber >= 1 && inputNumber <= 165 {
                        
                        ReserveRoom.Num = 3
                        ReserveSheet.Num = Int(alert.textFields?[0].text ?? "" )
                        
                        if self.checkingMultiful == 0 {
                            if self.usedSheet.contains(inputNumber) == false {
                                self.pleaseInputUsedSheet()
                            } else {
                                self.PostReserve.reserve(token: UserDevice.Token ?? "", roomNum: ReserveRoom.Num ?? 0 , sheetNum: ReserveSheet.Num ?? 0)
                            }
                        } else {
                            print("다중예약메소드")
                            
                            self.MultipleDataModel.inputData(room: ReserveRoom.Num ?? 0, sheet_num: ReserveSheet.Num ?? 0)
                            
                            print(self.MultipleDataModel.count)
                            
                            for i in 0..<self.MultipleDataModel.count {
                                //                            print(self.MultipleDataModel.printData()[i])
                            }
                            
                            print("오마이갓 !!")
                            print(self.MultipleDataModel.printData())
                            
                            self.PostMultiReserve.reserve(token: UserDevice.Token ?? "", data: self.MultipleDataModel.printData() as! Array<Any>)
                        }
                        LimitReserve.Number += 1
                        UserDefaults.standard.set(LimitReserve.Number, forKey: "Limit")
                        self.reserveConfirm()
                    } else {
                        self.pleaseCheckSheetNumber()
                    }
                }
            }
            alert.addAction(ok)
            self.checkingModel()
            self.present(alert, animated: true, completion: nil)
            
        } else {
                print("2자리라 예약 못혀")
            let alert = UIAlertController(title: "과부화 방지", message: "최대 2자리까지 예약 가능합니다.", preferredStyle: .alert)
    
        
            let cancel = UIAlertAction(title: "돌아가기", style: .cancel) { (cancel) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func reserveConfirm() {
        let alert = UIAlertController(title: "예약 성공 !", message: "자리가 비워지면 알려드릴게요.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel) { (cancel) in
            
            self.pushToResevereDetail()
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func pleaseCheckSheetNumber() {
        let alert = UIAlertController(title: "미등록 좌석", message: "자리를 확인하고 다시 예약해주세요.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .destructive) { (cancel) in
        }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pushToResevereDetail() {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ReserveDetail") as? ReserveDetail else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(LimitReserve.Number)
//        self.getReserveDetail()

        self.navigationItem.title = self.roomName ?? ""
//        self.view.bringSubviewToFront(self.hideView)
//        if self.roomName ?? "" == "제 1열람실" {
//            self.roomNumber = 1
//            self.getUsed()
//        } else if self.roomName ?? "" == "제 2열람실" {
//            self.roomNumber = 2
//            self.getUsed()
//        } else if self.roomName ?? "" == "제 3열람실" {
//            self.roomNumber = 3
//            self.getUsed()
//        }
    }
    
//    func getUsed() {
//        self.GetUsedSheet.getReserve(roomNumber: self.roomNumber, onCompleted: {
//            [weak self] result in // 순환 참조 방지, 전달인자로 result
//            guard let self = self else { return } // 일시적으로 strong ref가 되게
//
//            switch result {
//            case let .success(result):
//
//                self.usedSheet = result.use
//
//                print(result.room)
//                print(result.use)
//                print(result.notUse)
//
//            case let .failure(error):
//                debugPrint("error \(error)")
//            }
//        })
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUserToken = UserDevice.Token ?? ""
//        print(self.configureUserToken)
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
        if let roomName = roomName, let webSiteUrl = webSiteUrl {
            print(roomName)
            print(webSiteUrl)
            var sURL = webSiteUrl
            let uURL = URL(string: sURL)
            var request = URLRequest(url: uURL!)
            request.setValue("application/x-www-form-urlencoded",
                forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let postString = "파라미터"
            
            let encoding:UInt =  CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(
                    CFStringEncodings.EUC_KR.rawValue))

            request.httpBody = postString.data(using: String.Encoding(rawValue: encoding))!
//            request.httpBody = postString.data(using: .utf8)
            webView.load(request)
        }
    }
}
