//
//  ReserveDetail.swift
//  Warning
//
//  Created by 이주송 on 2022/09/25.
//

import UIKit
import WebKit

//MARK: - View + Controller
class ReserveDetail: UIViewController {
    
    //MARK: - View
    @IBOutlet weak var initalReseverDetailView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed(_:)))
        return button
    }()
    
    // MARK: - 사용할 View Model 1 초기화
    var MyReserveDataModel = MyReserveModel ()
    var MyReserveDataModel_2 = MyReserveModel ()
    
//    var testModel = CheckResponse ()
    // MARK: - 사용할 View Model 2 (API) 초기화
//    var GetReserve = getReserve ()
    
    var multiNum:[Int] = []
    var removeIndex:[Int] = []
    var wholeNum:[Int] = []
    var subtractWholeNum:[Int] = []
    var realNumArray:[Int] = []
    
    //MARK: - Controller
    @objc private func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MyReserveCells", bundle: .main), forCellReuseIdentifier: "MyReserveCells")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = self.leftButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.title = "내 예약정보"
//        self.getReserveDetail()
        self.tableView.reloadData()
    }
    
    // MARK: - API View Model 내 함수 선언
//    func getReserveDetail() {
//        self.GetReserve.getReserve(token: UserDevice.Token ?? "" , onCompleted: {
//            [weak self] result in // 순환 참조 방지, 전달인자로 result
//            guard let self = self else { return } // 일시적으로 strong ref가 되게
//
//            switch result {
//            case let .success(result):
//                 print(result)
//
//                var cellCount = result.data.data.count ?? 0
//
//                print("\(result.data.data[0].roomNum)열람실 \(result.data.data[0].sheetNum)번을 예약하셨습니다.")
//
//                for i in 0..<cellCount {
//                    self.MyReserveDataModel.inputData(room: result.data.data[i].roomNum, sheet_num: result.data.data[i].sheetNum)
//                }
//
//                print("**********************")
//                if self.MyReserveDataModel.count > 0 {
//                    for i in 0..<self.MyReserveDataModel.count {
//
//                        for k in 0..<self.MyReserveDataModel.count {
//                            self.wholeNum.append(k)
//
//                            if self.MyReserveDataModel.getSheetNum(index: i) == result.data.data[k].sheetNum && i != k {
//                                print("\(i)번과 \(k)번이 동일합니다.")
//                                self.multiNum.append(i)
//                                print(i)
//                            }                  // 2개 까지 가능 합니다.
//                        }
//                    }
//                }
//                self.subtractWholeNum = self.wholeNum.uniqued()
//                self.removeIndex = self.multiNum.uniqued()
//
//                for i in 0..<self.removeIndex.count {
//                    self.subtractWholeNum.indices.filter{self.subtractWholeNum[$0] == self.removeIndex[i]}.forEach{self.subtractWholeNum[$0] = 0}
//                }
//
//                self.realNumArray = self.subtractWholeNum.uniqued()
//
//                print(self.realNumArray)
//
//                self.initalReseverDetailView.isHidden = true
//                self.tableView.reloadData()
//
//            case let .failure(error):
//                debugPrint("error \(error)")
//            }
//        })
//    }
}

extension ReserveDetail: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MyReserveDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyReserveCells", for: indexPath) as? MyReserveCells else { return UITableViewCell() }
        
        var cellRoomNumber = self.MyReserveDataModel.getRoomNumber(index: indexPath.row)
        var cellSheetNumber = self.MyReserveDataModel.getSheetNum(index: indexPath.row)
        
        cell.roomLabel.text = "제 \(cellRoomNumber)열람실"
        cell.sheetNumLabel.text = "\(cellSheetNumber)번"
            
        switch cellRoomNumber {
        case 1:
            cell.roomImage.image = UIImage(named: "001_Color.png")
        case 2:
            cell.roomImage.image = UIImage(named: "002_Color.png")
        case 3:
            cell.roomImage.image = UIImage(named: "003_Color.png")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
