//
//  AppUtils.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/13/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit
import RealmSwift
typealias DownloadComplete = () -> ()
class AppUtils: NSObject {
    static var userviewmodel : UserViewModel? = nil
    static let BASE_URL = "http://192.168.1.22:8050/api/"
    static let FACEBOOK = 1
    static let GOOGLE = 2
    static let FORRENT = 1
    static let RENT = 2
    static var realm : Realm? = nil
    static var calendar : Calendar = {
        var a = NSCalendar.current
        a.timeZone = .current
        return a
    }()
     //==========================================================================================
    
    static func getUserViewModel() -> UserViewModel
    {
        
        if(userviewmodel == nil)
        {
            userviewmodel = UserViewModel()
        }
        return userviewmodel!
    }
    
    //==========================================================================================
    static func rentColor() -> UIColor
    {
       return  UIColor(red: 181.0/255.0, green: 47.0/255.0, blue: 47.0/255.0, alpha: 1.0)
    }
    
    static func forrentColor() -> UIColor
    {
        return  UIColor(red: 47.0/255.0, green: 181.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    }
    static func getInstance() -> Realm{
        
        realm = try! Realm()
        
        return realm!
    }
    
    static func storeUser(user : User){
        let preferences = UserDefaults.standard
        
        
        
        preferences.set(user.id, forKey: "id")
        preferences.set(user.name, forKey: "name")
        preferences.set(user.photoprofile, forKey: "photoprofile")
        preferences.set(user.type, forKey: "type")
        preferences.synchronize()
        
    }
    
    static func dayString(from interval : Double) -> String
    {
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yyyy" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
   
    
    static func countDay(from interval : Double) -> Int
    {
        
        let date =  calendar.date(byAdding: .hour, value: 0,to : Date(timeIntervalSince1970: interval))!
        print(date)
        
        if calendar.isDateInYesterday(date) { return -1 }
        else if calendar.isDateInToday(date) { return 0}
        else if calendar.isDateInTomorrow(date) { return 1 }
        else {
            let startOfNow = AppUtils.getStartLocalDate(date: calendar.date(byAdding: .hour, value: 0, to: Date())!)
            
            
            let startOfTimeStamp = AppUtils.getStartLocalDate(date: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            
            return day
            
        }
    }
    static func getStartLocalDate(date : Date)-> Date {
        var now = date
        
        var nowComponents = DateComponents()
        
        
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = 0
        nowComponents.minute = 0
        nowComponents.second = 0
        now = calendar.date(from: nowComponents)!
        return  calendar.date(byAdding: .hour, value: 0, to: now)!
    }
}
