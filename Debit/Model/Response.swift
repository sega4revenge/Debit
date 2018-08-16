//
//  Response.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/13/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import ObjectMapper

struct Response: Mappable {
    
    var message: String?
    var status: Int?
    var user : User?
    init() {
        
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
        user <- map["user"]
     
    }
}
