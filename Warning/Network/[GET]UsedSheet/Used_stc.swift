// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usedSheet = try? newJSONDecoder().decode(UsedSheet.self, from: jsonData)

import Foundation

// MARK: - UsedSheet
struct UsedSheet: Codable {
    let room: Room
    let use, notUse: [Int]

    enum CodingKeys: String, CodingKey {
        case room, use
        case notUse = "not_use"
    }
}

// MARK: - Room
struct Room: Codable {
    let start, end: Int
}
