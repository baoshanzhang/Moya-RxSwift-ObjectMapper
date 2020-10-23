//
//  TestAPI.swift
//  Moya+RxSwift+ObjectMapper
//
//  Created by Developer on 2020/10/21.
//
import Moya

enum TestAPI {
    case test
}

extension TestAPI: API{

    public var baseURL: URL {
        return URL(string: "https://www.douban.com")!
    }
    
    public var path: String {
        return "/j/app/radio/channels"
    }
    
    public var method: Method {
        return .get
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
}


