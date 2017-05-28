//
//  DesignableButton.swift
//  tagwaiter
//
//  Created by Manu on 27/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {
        
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
