//
//  NetWorking.swift
//  swiftText
//
//  Created by jingjun on 2018/4/9.
//  Copyright © 2018年 景军. All rights reserved.
//

import Foundation
import Moya
import MoyaSugar
import RxSwift

typealias APINetWorking = NetWorking<APIManager>
final class NetWorking<Target:SugarTargetType>:MoyaSugarProvider<Target>{
    init(plugins:[PluginType] = []){
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 50
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        super.init(manager: manager, plugins: plugins)

    }
    
    
    func request(_
        target: Target,
        file : StaticString = #file,
        function:StaticString = #function,
        line : UInt = #line
        ) -> Single<Response>{
        let requestString = "\(target.url)"
        
        return self.rx.request(target).do(onSuccess: { (response) in
            print(response.data,response.statusCode)
        }, onError: { (error) in
            print(error)
        }, onSubscribe: {
            print(requestString)
        }, onSubscribed: {
            
        }, onDispose: {
            
        })
        
        
    }
    
}


















