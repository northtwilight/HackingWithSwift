//
//  ViewController.swift
//  HWS16-CapitalCities
//
//  Created by Massimo Savino on 2022-08-04.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    private struct Constants {
        static let capitalIdentifier = "Capital"
    }

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        let viewModel = ViewModel()
        for capital in viewModel.cities {
            mapView.addAnnotation(capital)
            print("  Title: \(capital.title!)")
            print("  Coordinate: \(capital.coordinate)")
            print("  Info: \(capital.info)\n")
        }
        print("cities' count: \(self.mapView.annotations.count)")
        
        for annotation in self.mapView.annotations {
            print("Annotation: \(annotation)")
            print("annotation.title: \(annotation.title!)")
            print("annotation.coord: \(annotation.coordinate)")
            print("annotation.debugDescription: \(annotation.debugDescription!)\n")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else {
            print("Can't set annotation to view, exiting early")
            return nil
        }
        
        // 2
        let identifier = Constants.capitalIdentifier
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            // 4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {
            print("Can't set capital, so can't set details")
            return
        }
        let placeName = capital.title
        let placeInfo = capital.info
        print("placeName is supposed to be: \(placeName)")
        print("placeInfo is supposed to be: \(placeInfo)")
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

