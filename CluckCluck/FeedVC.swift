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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
        //Now we need to do 2 things: SignOut of Firebase and remove our ID from the keychain
        
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("TYRON: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        //dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "signInPage", sender: nil)
    }
}
