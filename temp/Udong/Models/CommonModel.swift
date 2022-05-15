//
//  ModelSample.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/04.
//

import Foundation

struct NetkResponse<T: Codable>: Codable{
    let success: Bool?
    var data: T?
    let error: Bool?
    
}
