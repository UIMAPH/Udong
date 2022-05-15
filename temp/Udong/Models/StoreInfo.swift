// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeInfo = try? newJSONDecoder().decode(StoreInfo.self, from: jsonData)

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    var storeName: String?
    let visitCount: Int?
    let reviewCount: Int?
    let regularCustomerCount: Int?
    let myStoreTier: String?
    let myVisitCount: Int?
    let regularCustomerTop5: [RegularCustomerTop5]?
    let address, phone: String?
    let businessHours: BusinessHours?
    let menu: [Menu]?
}

// MARK: - BusinessHours
struct BusinessHours: Codable {
    let mon, tue, wed, thu: String?
    let fri, sat, sun: String?
}

// MARK: - Menu
struct Menu: Codable {
    let id: Int?
    let item, price: String?
}

// MARK: - RegularCustomerTop5
struct RegularCustomerTop5: Codable {
    let id: Int?
}

