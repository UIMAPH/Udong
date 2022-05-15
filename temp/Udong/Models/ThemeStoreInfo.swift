// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storeInfo = try? newJSONDecoder().decode(StoreInfo.self, from: jsonData)

import Foundation


// MARK: - DataClass
struct DataStoreArr: Codable {
    let store: [Store]?
}

// MARK: - Store
struct Store: Codable {
    let id: Int?
    let storeName, image: String?
}
