//
//  ViewController.swift
//  tagwaiter
//
//  Created by Manu on 30/3/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Set to white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }


}

