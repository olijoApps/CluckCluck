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
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // We can add a "listener" to observe and listen for changes under each branch on firebase
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
        })
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        } else {
            return PostCell()
        }
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
