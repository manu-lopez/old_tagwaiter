//
//  ItemMenu.swift
//  tagwaiter
//
//  Created by Manu on 25/5/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit

class ItemMenu: UITableViewCell {
    
    
    @IBOutlet weak var ProductImg: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    
}

class PromoItemMenu: UITableViewCell{
    
    @IBOutlet var ProductImg: UIView!
    @IBOutlet var ProductoName: UILabel!
}

class CuentaItem: UITableViewCell{
    @IBOutlet var info: UILabel!
}
