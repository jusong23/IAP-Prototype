//
//  MyReserveModel.swift
//  Warning
//
//  Created by 이주송 on 2022/10/02.
//

import Foundation

// MARK: - View Model
class MyReserveModel {
    
    // MARK:  사용할 Model 초기화
    public var myReserveStc: [MyReserveStc] = [
    ]
    
    // MARK: Variable
    public var count: Int {
        return myReserveStc.count
    }
    
    // MARK: Functuin
    public func getRoomNumber(index: Int) -> Int {
        return myReserveStc[index].room ?? 0
    }
    
    public func getSheetNum(index: Int) -> Int {
        return myReserveStc[index].sheet_num ?? 0
    }
    
    
    public func inputData(room:Int, sheet_num:Int) {
        self.myReserveStc.append(MyReserveStc(room: room, sheet_num: sheet_num))
    }
    
    
    public func removeData(index:Int) {
        self.myReserveStc.remove(at: index)
    }
    
    public func printData() -> Array<Any> {
        return self.myReserveStc
    }
    
}
