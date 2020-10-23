//
//  TestModel.swift
//  Moya+RxSwift+ObjectMapper
//
//  Created by Developer on 2020/10/22.
//

import Foundation
import ObjectMapper

struct TestModel: Mappable {
    
    var channels = [TestListModel]()
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        channels   <- map["channels"]
    }
    
}


struct TestListModel: Mappable {
    
    var abbr_en: String = ""
    var channel_id: Int = 0
    var name: String = ""
    var name_en: String = ""
    var seq_id: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        abbr_en      <- map["abbr_en"]
        channel_id   <- map["channel_id"]
        name         <- map["name"]
        name_en      <- map["name_en"]
        seq_id       <- map["seq_id"]
    }
}
