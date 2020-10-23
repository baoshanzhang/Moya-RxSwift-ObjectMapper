//
//  ObjectMapperExtension.swift
//  Moya+RxSwift+ObjectMapper
//
//  Created by Developer on 2020/10/21.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapObject<T: BaseMappable>(type: T.Type) -> Single<T> {
        return self.map { response in
            return try response.mapObject(type: type)
        }
    }
    
    func mapArray<T: BaseMappable>(type: T.Type) -> Single<[T]> {
        return self.map { response  in
            return try response.mapArray(type: type)
        }
    }
}

public extension ObservableType where Element == Response {
    
    func mapObject<T: BaseMappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            return try response.mapObject(type: type)
        }
    }
    
    func mapArray<T: BaseMappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            return try response.mapArray(type: type)
        }
    }
    
}

public extension Response {
    
    func mapObject<T: BaseMappable>(type: T.Type) throws -> T {
        guard let text = String(bytes: self.data, encoding: .utf8) else { return T.self as! T  }
        if self.statusCode == 200 {
            return Mapper<T>().map(JSONString: text)!
        }
        do {
            let serviceError = Mapper<ServiceError>().map(JSONString: text)
            throw serviceError!
        } catch {
            if error is ServiceError {
                throw error
            }
            var serviceError = ServiceError()
            serviceError.msg = "服务器失联了，请稍后再试"
            serviceError.code = "parse_error"
            throw serviceError
        }
    }
    
    func mapArray<T: BaseMappable>(type: T.Type) throws -> [T] {
        let text = String(bytes: self.data, encoding: .utf8)
        if self.statusCode == 200 {
            return Mapper<T>().mapArray(JSONString: text!)!
        }
        do {
            let serviceError = Mapper<ServiceError>().map(JSONString: text!)
            throw serviceError!
        } catch {
            if error is ServiceError {
                throw error
            }
            var serviceError = ServiceError()
            serviceError.msg = "服务器失联了，请稍后再试"
            serviceError.code = "parse_error"
            throw serviceError
        }
    }
}
struct ServiceError: Error, Mappable{
    
    var msg: String = ""
    
    var code: String = ""
    
    init?(map: Map) {}
    
    init() {}
    
    mutating func mapping(map: Map) {
        code <- map["error_code"]
        msg <- map["error"]
    }
    
    var localizedDescription: String{
        return msg
    }
}

struct BaseModel<T: Mappable> {
    
    public var code: Int = 0
    
    public var msg: String = ""
    
    public var data: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code   <- map["code"]
        msg    <- map["msg"]
        data   <- map["data"]
    }
    
}


