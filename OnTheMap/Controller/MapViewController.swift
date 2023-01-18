//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Deer on 6/11/1441 AH.
//  Copyright © 1441 Deer All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate{
  
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var annotations = [MKPointAnnotation]()
        mapView.delegate = self

        
        parseAPI.getRequest(completionHandler:{ (StudentLocationList, error) in
                    
            for StudentLocation in StudentLocationList?.results ?? [] {
                
                let lat = CLLocationDegrees(StudentLocation.latitude )
                let long = CLLocationDegrees(StudentLocation.longitude )
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = StudentLocation.firstName
                let last = StudentLocation.lastName
                let mediaURL = StudentLocation.mediaURL
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
                
            }
            self.mapView.addAnnotations(annotations)
        })

        
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
    
    @IBAction func logoutTapped(_ sender: Any) {
    
        UdacityAPI.deleteSession(completionHandler:{ (error) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
            
        
}
        
    

    

