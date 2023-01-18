//
//  ConfirmLocationViewController.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//

import UIKit
import MapKit

class ConfirmLocationViewController : UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    struct locationInfo {
        static var location = ""
        static var link = ""
        static var lat = 0.0
        static var long = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: locationInfo.lat , longitude: locationInfo.long)
        zoomingMap(coordinate, mapView: mapView)
        annotation.coordinate = coordinate
        annotation.title = "\(locationInfo.location)"
        annotation.subtitle = "\(locationInfo.link)"
        
        self.mapView.addAnnotation(annotation)
        
    }
    
    @IBAction func finishTapped(_ sender: Any) {
        parseAPI.postRequest(location: locationInfo.location, link: locationInfo.link, lat: locationInfo.lat, long: locationInfo.long) {(StudentLocationList ,error) in
            guard error != nil else{
                print(error!)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func zoomingMap(_ location: CLLocationCoordinate2D, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    
}
