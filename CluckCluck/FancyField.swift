//
//  FancyField.swift
//  CluckCluck
//
//  Created by Tyron Spencer on 14/7/17.
//  Copyright © 2017 Tyron Spencer. All rights reserved.
//

import UIKit

class FancyField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.5).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
    }
    
    // textRect will affect the placeholder text of a text field
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
}
