//
//  ViewController.swift
//  Debit
//
//  Created by Tô Tử Siêu on 8/9/18.
//  Copyright © 2018 Tô Tử Siêu. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginFacebook(_ sender: CornerButton) {
    }
    @IBAction func loginGoogle(_ sender: CornerButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

}

