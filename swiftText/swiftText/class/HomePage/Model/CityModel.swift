//
//  CityModel.swift
//  swiftText
//
//  Created by jingjun on 2018/7/31.
//  Copyright © 2018年 景军. All rights reserved.
//

import Foundation
import HandyJSON

struct CityModel: HandyJSON {
    init() {
        
    }
    var id : Int = 0
    var name: String = ""
    var cities : [cities] = []
}
struct cities: HandyJSON {
    init() {
        
    }
    var id: Int = 0
    var name: String = ""
}
