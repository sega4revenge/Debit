//
//  Debit.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/13/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

import ObjectMapper
import RealmSwift
class Debit: Object,Mappable {
    
  
    
    @objc dynamic var _id : String?
     @objc dynamic var name: String?
    @objc dynamic var type: Int = 0
     @objc dynamic  var timestart: Double = 0.0
     @objc dynamic  var timeend: Double = 0.0
     @objc dynamic  var ammount: String?
     @objc dynamic  var typeammount: Int = 0
    @objc dynamic var notification : Bool = false

    required convenience init?(map: Map) {
        self.init()
    }
    
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
    
    
    func mapping(map: Map) {
        _id <- map["_id"]
         name <- map["name"]
        type <- map["type"]
        timestart <- map["timestart"]
        timeend <- map["timeend"]
        ammount <- map["ammount"]
        notification <- map["notification"]
       
    }
}
