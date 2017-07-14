//
//  RoundBtn.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 14/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.9) .cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0.5, height: 4.0)
        imageView?.contentMode = .scaleAspectFit
        
        // Rounding the corners of a button:
        //layer.cornerRadius = 10
    }
        
        // Making a complete circle shaped button
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
    
}
