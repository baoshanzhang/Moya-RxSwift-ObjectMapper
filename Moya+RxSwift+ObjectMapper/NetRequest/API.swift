//
//  API.swift
//  Moya+RxSwift+ObjectMapper
//
//  Created by Developer on 2020/10/21.
//

import Moya

public protocol NetTargetType: TargetType {
    var parameters: [String: Any]? { get }
}

extension NetTargetType {
    public var parameters: [String: Any]? {
        return nil
    }
}

protocol API: NetTargetType {
    func parameterEncoding() -> Moya.ParameterEncoding
}

extension API {
    
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    func parameterEncoding() -> Moya.ParameterEncoding {
        return URLEncoding.default
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json;charset=UTF-8"]
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding())
    }
    
    /// 处理单元测试 暂时不用
    public var sampleData: Data {
        return Data()
    }
    
}
