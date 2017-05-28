//
//  DesignableView.swift
//  tagwaiter
//
//  Created by Manu on 27/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
