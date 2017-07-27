//
//  PostCell.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 22/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // nil at the end of the below line means to set its default value to nil
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data,error) in
                
                    //Now we are inside the completion handler
                if error != nil {
                    print("TYRON: Unable to download image from firebase storage")
                } else {
                    //Now we want to change the image we download to image data to store in our image cache!
                    print("TYRON: Image downloaded from firebase storage")
                    // Save data to cache:
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
    }
}














