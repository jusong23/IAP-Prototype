// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkResponse = try? newJSONDecoder().decode(CheckResponse.self, from: jsonData)

import Foundation

// 1. 가져오려는 Json 데이터를 Decode하는 Model(Check_stc.swift)을 만든다. (택배 박스)
// 2. 이 Model에 담기는 데이터를 조작할 View Model(Check_api.swift)을 만든다. (택배 회사)
// 3. ViewController에 View Model을 초기화 한다. (물건을 발주한 셀러)
// (참고. MVVM에서는 Model과 Controller가 직접 소통하지 않음 cf.옵저버패턴)
// 4. ViewController을 실행하면, View Model 내 에있는 Model에 데이터가 담기고, View Model는 이를 이용한다. (사용자 정의 함수)

// MARK: - Model

// MARK: - CheckResponse
struct CheckResponse: Codable {
    let id, name: String
    let data: DataClass
    let endDate, lastModifiedBy: JSONNull?
    let priority: Int
    let repeatInterval: String
    let repeatTimezone: JSONNull?
    let shouldSaveResult: Bool
    let skipDays, startDate: JSONNull?
    let type, nextRunAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, data, endDate, lastModifiedBy, priority, repeatInterval, repeatTimezone, shouldSaveResult, skipDays, startDate, type, nextRunAt
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let token: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let roomNum, sheetNum: Int

    enum CodingKeys: String, CodingKey {
        case roomNum = "room_num"
        case sheetNum = "sheet_num"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


