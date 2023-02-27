//
//  Reserve_stc.swift
//  Warning
//
//  Created by 이주송 on 2022/09/25.
//

import Foundation

// MARK: - ReserveRequest
struct MultiRequest: Codable {
    let token: String
    let data: [Datum_MultiRequest]
}

// MARK: - Datum
struct Datum_MultiRequest: Codable {
    let roomNum, sheetNum: Int

    enum CodingKeys: String, CodingKey {
        case roomNum = "room_num"
        case sheetNum = "sheet_num"
    }
}


// MARK: - ReserveResponse
struct MultiResponse: Codable {
    let isSuccess: Bool
}

