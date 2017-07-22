//
//  FeedVC.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 22/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        //Now we need to do 2 things: SignOut of Firebase and remove our ID from the keychain
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("TYRON: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
      
        performSegue(withIdentifier: "goToSignIn", sender: (Any).self)
        
    }
}
