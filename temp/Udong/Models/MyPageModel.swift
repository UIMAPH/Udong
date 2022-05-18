//
//  MyPageModel.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/18.
//

import Foundation
import UIKit

struct MainMyPageModel: Codable {
    let userId: Int?
    let username: String?
    let profileImageUrl: String?
    let regionName: String?
    let usingBadgeId: Int?

//    enum CodingKeys: String, CodingKey {
//        case userID
//        case username
//        case profileImageURL
//        case regionName
//        case usingBadgeID
//    }
}
