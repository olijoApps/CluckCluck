//
//  FancyView.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 14/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.9) .cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0.5, height: 4.0)
        
        
    }

}
