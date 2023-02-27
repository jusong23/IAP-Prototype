//
//  MyReserveModel.swift
//  Warning
//
//  Created by 이주송 on 2022/10/02.
//

import Foundation

class MultipleModel {
    
    public var multipleStc: [Datum_MultiRequest] = [
    ]
    
    // MARK: - var
    
    public var count: Int {
        return multipleStc.count
    }
    
    // MARK: - func
    
    public func getRoomNumber(index: Int) -> Int {
        return multipleStc[index].roomNum ?? 999
    }
    
    public func getSheetNum(index: Int) -> Int {
        return multipleStc[index].sheetNum ?? 999
    }
    
    public func inputData(room:Int, sheet_num:Int) {
        self.multipleStc.append(Datum_MultiRequest(roomNum: room, sheetNum: sheet_num))
    }

    public func printData() -> Any {
        return self.multipleStc
    }
    
}
