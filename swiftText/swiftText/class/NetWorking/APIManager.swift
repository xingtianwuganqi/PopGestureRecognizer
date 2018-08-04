//
//  APIManager.swift
//  swiftText
//
//  Created by jingjun on 2018/4/8.
//  Copyright © 2018年 景军. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar

enum APIManager {
    case myTimeLine(page:Int?, last: Int?)
    case myPaon(pid:String)
    case channel(page: Int?, last: Int?)
    case channelList
    case advertisement
    case channelProducts(channelId: Int, page: Int?)
    case userInfo(nickname:String,avatar:String,cityID:String,remark:String)
    case location
}

extension APIManager : SugarTargetType{
    
    
    var baseURL: URL {
        return URL(string: "https://api-test.720yun.com")!
    }
    
    var url: URL {
        
        return self.defaultURL
    }
    

    
    var route: Route {
        switch self {
        case .myTimeLine:
            return .get("/timeline")
        case .myPaon:
            return .get("/app/products")
        case .channel:
            return .get("/timeline/selected")
        case .advertisement:
            return .get("/app/advertisement")
        case .channelList:
            return .get("/channels")
        case .channelProducts:
            return .get("/products")
        case .userInfo:
            return .post("/member/me")
        case .location:
            return .get("/locations")
        }
    }
    
    var parameters: Parameters? {
        switch self {
            
        case .channel(let page ,let last):
            return [
                "page": page ?? 1,
                "last": last ?? 0
            ]
        case .channelProducts( let channelId, let page):
            return [
                "channelId" : channelId,
                "page" : page ?? 1
            ]
        case .myTimeLine(page: let page, last: let last):
            return [
                "page": page,
                "last": last
            ]
            
        case .myPaon(pid: let pid):
            return ["pid":pid]
        case .userInfo(nickname: let nick, avatar: let avatar, cityID: let cityID, remark: let remark):
            return [
                "nickname":nick,
                "avatar":avatar,
                "cityId" : cityID,
                "remark" : remark
            
            
            ]
        default:
            return [:]
        }
    }
    
    

    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestParameters(parameters: self.parameters?.values ?? [:], encoding: URLEncoding.default)
    }
    var validate: Bool {
        
        return false
    }
    var headers: [String: String]? {
        
        switch self {
        case .myTimeLine:
            return ["App-Key": "aUWCj8QTNX2REohWFEawgioK6LBwm72W",
                    "App-Authorization": "",
                    "Referer": "https://test.720yun.com",
                    "Origin": "https://test.720yun.com"]
        default:
            return [
                "App-Key": "aUWCj8QTNX2REohWFEawgioK6LBwm72W",
                "Referer": "https://test.720yun.com",
                "Origin":  "https://test.720yun.com"
            ]
        }
        
    
        
    }
}
extension APIManager {
    
    static func parseSuccessResponse(_ json: Any?) -> Bool {
        guard let json = json as? [String: Any] else {
            return false
        }
        guard (json["success"] as? Int) == 1 else {
            return false
        }
        
        return true
    }
    static func parseResponse(_ json: Any?) -> [String: Any] {
        guard let json = json as? [String: Any] else {
            return [:]
        }
        guard (json["success"] as? Int) == 1 else {
            return [:]
        }
        guard let data = json["data"] as? [String: Any] else {
            return [:]
        }
        return data
    }
    static func parseListResponse(_ json: Any?) -> [String] {
        
        guard let json = json as? [String: Any] else {
            return []
        }
        guard (json["success"] as? Int) == 1 else {
            return []
        }
        guard let data = json["data"] as? [[String: Any]] else {
            return []
        }
        
        let jsonString = data.map { (item) -> String? in
            
            guard let itemData = try? JSONSerialization.data(withJSONObject: item, options: []) else {
                return nil
            }
            
            return String(data: itemData, encoding: .utf8)
            }
            .filter { (jsonString) -> Bool in
                return jsonString != nil
        }
        
        return jsonString as! [String]
    }
    
    
    static func parseIntListResponse(_ json: Any?) -> [Int] {
        
        guard let json = json as? [String: Any] else {
            return []
        }
        guard (json["success"] as? Int) == 1 else {
            return []
        }
        guard let data = json["data"] as? [Int] else {
            return []
        }
        
        return data
    }
    
}

