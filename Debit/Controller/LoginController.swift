//
//  ViewController.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/9/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase
import GoogleSignIn
class LoginController: UIViewController, GIDSignInUIDelegate,GIDSignInDelegate {
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginFacebook(_ sender: CornerButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions : [ .email,.publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
          
                let toast = Toast(text: "\("networkerror".localized(tableName: "Main"))", duration: Delay.short)
                toast.show()
                print(error)
            case .cancelled:
            
                let toast = Toast(text: "\("userdecline".localized(tableName: "Main") )", duration: Delay.short)
                toast.show()
                
            case .success( _, _, _):
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"], accessToken: AccessToken.current, httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!, apiVersion: "2.8")) { httpResponse, result in
                    
                    switch result {
                    case .success(let response):
                      
                        self.loginsocial(id: response.dictionaryValue?["id"] as! String, name: response.dictionaryValue?["name"] as! String, photoprofile: "https://graph.facebook.com/\((response.dictionaryValue?["id"])!)/picture?type=large", type: 0)
                        print(response)
                      
                        
                    case .failed(let error):
                      
                        let toast = Toast(text: "\("networkerror".localized(tableName: "Main") )", duration: Delay.short)
                        toast.show()
                        print("Graph Request Failed: \(error)")
                    }
                }
                
                connection.start()
            }
        }
    }
    @IBAction func loginGoogle(_ sender: CornerButton) {
          GIDSignIn.sharedInstance().signIn()
        
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                     withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            //            let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            //            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            //            let email = user.profile.email
    
           self.loginsocial(id: user.userID     , name: user.profile.name, photoprofile: (user.profile.imageURL(withDimension: 320)).absoluteString, type: 1)
         
            // ...
        } else {
            print("\(error)")
        }
    }
    func loginsocial(id : String,name : String,photoprofile : String,type : Int)
    {
        
        AppUtils.getUserViewModel().loginUser(id : id,name : name,photoprofile : photoprofile,type : type){
            
            switch (AppUtils.getUserViewModel().response?.status){
            case 200 :
                AppUtils.getUserViewModel().response?.user?.type = type
                self.getData(user: (AppUtils.getUserViewModel().response?.user)!)
                
            case nil :
                ToastCenter.default.cancelAll()
                let toast = Toast(text: "\("networkerror".localized(tableName: "Main"))", duration: Delay.short)
             
                toast.show()
            default :
                ToastCenter.default.cancelAll()
                let toast = Toast(text: "\("signinok".localized(tableName: "Main"))", duration: Delay.short)
                
                toast.show()
                
                
            }
        }
    }
    func getData(user : User){
     
        AppUtils.storeUser(user: user)
        
        //        AppUtils.setReminder(from: user.listgroup[0].listproduct,viewcontroller: self)
        //            {
        //
        //
        //
        //            }
        
        
        try! AppUtils.getInstance().write {
            
            AppUtils.getInstance().deleteAll()
            
            AppUtils.getInstance().add(user, update: true)
            self.performSegue(withIdentifier: "goto_home", sender: self)
            
          
     
        }
        
    }
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

}

