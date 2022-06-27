// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeInfo = try? newJSONDecoder().decode(StoreInfo.self, from: jsonData)

import Foundation

// MARK: - StoreInfo
struct BadgeModel: Codable {
    let badgeID: Int?
    let badgeName: String?
    let active: Bool?

    enum CodingKeys: String, CodingKey {
        case badgeID
        case badgeName, active
    }
}
