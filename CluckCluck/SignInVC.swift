//
//  ViewController.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 13/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        // The first step is to check in with facebook all good to go ahead:
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("TYRON: Unable to authenticate with facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("TYRON: User cancelled facebook authenicating")
            } else {
                print("TYRON: Successfully authenticated with facebook")
                let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credentials)
            }
        }
    }
    
    // Now to authenticate with Firebase:
    func firebaseAuth(_ credentials: AuthCredential) {
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("TYRON: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("TYRON: Successfully authenticated with Firebase")
            }
        })
    }
    
}



