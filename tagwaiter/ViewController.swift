//
//  ViewController.swift
//  tagwaiter
//
//  Created by Manu on 30/3/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import UIKit
import CoreLocation //obtener localizacion usuario
import Alamofire //hacer consultas al servidor

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var qrCode: String?
    var haveQrCode = false
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBAction func buttonQR(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        currentLocation = locationManager.location
        
        if haveQrCode == true {
            verifyConnection(code: qrCode!, latitud: currentLocation.coordinate.latitude, longitud: currentLocation.coordinate.longitude)
        }
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    //Set to white status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func verifyConnection(code: String, latitud: Double, longitud: Double) {
        //        var conn = false
        
        print("latidud: \(latitud)")
        print("Longitud: \(longitud)")
        
//        Alamofire.request("http://api.disainin.com/foodtags/1/access/qr/\(code)/\(latitud)/\(longitud)").responseString{ (AlamofireRepsonse) in
//            print(AlamofireRepsonse.result.value!)
//        }
        //        return conn
    }
    
}

