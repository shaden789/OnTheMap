//
//  AddViewController.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//


import UIKit
import CoreLocation

class AddViewController :UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var link: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationText.delegate = self
        link.delegate = self
        
    }
    
    @IBAction func findLocation(_ sender: Any) {
        
        guard locationText.text != "" ,  link.text != "" else {
            showFailure(title: "Error", message: "you should fill the location and the link!")
            return
        }
        
        ConfirmLocationViewController.locationInfo.location = self.locationText.text!
        ConfirmLocationViewController.locationInfo.link = self.link.text!
        
        CLGeocoder().geocodeAddressString((locationText.text)!) { (placemarks, error) in
            guard let placemarks = placemarks else {
                DispatchQueue.main.async {
                    self.showFailure(title: "Geocode Error", message: "Error finding location!")
                }
                return
            }
            let placemark = placemarks.first
            let latitude = placemark?.location?.coordinate.latitude
            let longitude = placemark?.location?.coordinate.longitude
            
            ConfirmLocationViewController.locationInfo.lat = latitude!
            ConfirmLocationViewController.locationInfo.long = longitude!
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLocationSegue", sender: self)
            }
        }
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showFailure(title: String ,message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
