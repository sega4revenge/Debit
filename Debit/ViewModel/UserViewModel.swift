//
//  UserModel.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/13/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
class UserViewModel: NSObject {
    //Create apiClient property that we can use to call in our API Call.
    //This apiClient property is marked as an @IBOutlet so that we can instantiate it from the storyboard.  I mark this with a bang operator (!) since I know it will not be nil since the storyboard will be injecting it.
    var user : User = User()
    var response : Response?
    var status : Int?
    
  
   
    func loginUser(id : String,name : String,photoprofile : String,type : Int,complete : @escaping DownloadComplete){
        
        let parameters : Parameters = [
            "id" : id,
            "name": name,
            "photoprofile": photoprofile,
               "type": type
            
        ]
        print("\(id)+\(type)".toBase64()!)
        Alamofire.request(AppUtils.BASE_URL + "authenticate", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<Response>) in
            self.response = response.result.value
            print(self.response)
            complete()
        }
    }
    
    
    
    
    
}
