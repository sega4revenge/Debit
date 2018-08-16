//
//  User.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/13/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

import ObjectMapper
import RealmSwift
class User: Object,Mappable {

    
    
    @objc dynamic var id : String?
    @objc dynamic var name: String?
    @objc dynamic var last_login: Double = 0.0
    @objc dynamic var photoprofile: String?
    @objc dynamic var type : Int = 0
    @objc dynamic var secret : String?
    var listdebit = List<Debit>()
    required convenience init?(map: Map) {
        self.init()
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        last_login <- map["last_login"]
          photoprofile <- map["photoprofile"]
          type <- map["type"]
             secret <- map["secret"]
        listdebit <- (map["listdebit"], ListTransform<Debit>())
      
    }
}
