//
//  ScannerViewController.swift
//  tagwaiter
//
//  Created by Manu on 23/4/17.
//  Copyright © 2017 Manu. All rights reserved.
//

import AVFoundation
import UIKit
import CoreLocation
import Alamofire
import RealmSwift

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var topbar: UIView!
    
    @IBOutlet var sendQRButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    //Hide statusBar
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
            
        //opciones boton
        sendQRButton.isEnabled = false
        sendQRButton.alpha = 1
        sendQRButton.backgroundColor = UIColor.black
        sendQRButton.setTitle("Escanea un QR", for: .normal)

        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: sendQRButton)
            view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
                
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    var qrCode: String!
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                qrCode = metadataObj.stringValue!
                
                sendQRButton.isEnabled = true
                sendQRButton.backgroundColor = UIColor.green
                sendQRButton.setTitle("Escanear", for: .normal)
                sendQRButton.alpha = 1
            }
        }
    }
    
    @IBAction func CloseScanner(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendQR(_ sender: Any) {
        
        captureSession?.stopRunning()
        sendQRButton.backgroundColor = UIColor.blue
        sendQRButton.setTitle("Escaneando...", for: .normal)
        
        do {
            
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location!
            
            
            verifyConnection(code: qrCode!, latitud: currentLocation.coordinate.latitude, longitud: currentLocation.coordinate.longitude)
        } catch {
            print("error")
            let alert = UIAlertController(title: "Error", message: "Vuelva a intentarlo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Probar de nuevo", style: .default, handler: self.novalid))
        }
        

    }
    
    func verifyConnection(code: String, latitud: Double, longitud: Double)
    {
        
        Alamofire.request("http://api.disainin.com/foodtags/1/access/qr/\(code)/\(latitud)/\(longitud)").responseJSON { response in
            
            
            //guardamos los valores de sesion, nos harán falta luego
            if let JSON = response.result.value as? [String: Any] {
                if let name = JSON["name"] as? String {
                    UserDefaults.standard.set(name, forKey: "shopName")
                }
                if let sessionId = JSON["sessionId"] as? String {
                    UserDefaults.standard.set(sessionId, forKey: "sessionId")
                }
                if let shopId = JSON["shopId"] as? String {
                    UserDefaults.standard.set(shopId, forKey: "shopId")
                }
                if let token = JSON["token"] as? String {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                if let valid = JSON["valid"] as? Bool {
                    
                    UserDefaults.standard.set(valid, forKey: "valid")
                    
                    if valid == true {
                        //obtenemos el lenguaje del móvil, para mostrar los textos correspondientes
                        UserDefaults.standard.set(NSLocale.current.identifier, forKey: "lang")
                        
                        //Creamos la sesion
                        var sesion = Session()
                        var sesionOrder = SessionOrder()
                        
                        let realm = try! Realm()
                        
                        try! realm.write {
                            realm.add(sesion)
                            realm.add(sesionOrder)
                        }
                        
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let inicioVC = storyBoard.instantiateViewController(withIdentifier: "Inicio")
                        self.present(inicioVC, animated: true, completion: nil)
                        
                    } else {
                        
                        let alert = UIAlertController(title: "No se ha podido conectar", message: "No se ha podido conectar, puede que la mesa esté ocupada", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Probar de nuevo", style: .default, handler: self.novalid))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    
    //funcion para el alert de no conectar
    func novalid(action: UIAlertAction){
        self.viewDidLoad()
    }
}
