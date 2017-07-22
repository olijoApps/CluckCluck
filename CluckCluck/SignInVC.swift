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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
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
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        // So once the SignIn button is tapped, we need to make sure that there is text in the fields
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("TYRON: Congrats, email user authenticated with Firebase - you've signed in")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("TYRON: Unable to authenticate with Firebase using Email - Password must be atleast 6 characters long")
                        } else {
                            print("TYRON: Successfully authenticated with firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("TYRON: Data successfully saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
}

















