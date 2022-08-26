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

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        let viewModel = ViewModel()
        let capitals = viewModel.cities
        
        for capital in capitals {
            mapView.addAnnotation(capital)
            print("  Title: \(capital.title!)")
            print("  Coordinate: \(capital.coordinate)")
            print("  Info: \(capital.info)\n")
        }
        
        let vancouver = Capital(
            title: "Vancouver",
            coordinate: CLLocationCoordinate2D(
                latitude:  49.246292,
                longitude: -123.116226),
            info: "Royally effed in every way")
        
        mapView.addAnnotation(vancouver)
        
        print("cities' count: \(self.mapView.annotations.count)")
        
        let mapViewAnnotations = self.mapView.annotations
        
        for annotation in mapViewAnnotations {
            print("Annotation: \(annotation)")
            print("annotation.title: \(annotation.title!!)")
            print("annotation.coord: \(annotation.coordinate)")
            print("annotation.debugDescription: \(annotation.debugDescription!)\n")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {
            print("Can't set annotation to view, exiting early")
            return nil
        }
        
        let identifier = Constants.capitalIdentifier
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            print("\(#function):  building annotation view anew")
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            
            print("existing annotation \(annotation) being loaded")
            annotationView?.annotation = annotation
            print("loading annotation: \(annotation)")
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

