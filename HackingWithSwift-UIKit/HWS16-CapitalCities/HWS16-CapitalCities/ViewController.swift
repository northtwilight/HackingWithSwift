//
//  ViewController.swift
//  HWS16-CapitalCities
//
//  Created by Massimo Savino on 2022-08-04.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    private struct Constants {
        static let londonInfo = "Home to the 2012 Summer Olympics"
        static let osloInfo = "Founded over a thousand years ago."
        static let parisInfo = "Often called the City of Light"
        static let romeInfo = "Has a whole country inside it."
        static let washingtonInfo = "Named after George himself."
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: Constants.londonInfo)
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: Constants.osloInfo)
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: Constants.parisInfo)
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: Constants.romeInfo)
    let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: Constants.washingtonInfo)
    
    lazy var capitals: [Capital] = [london, oslo, paris, rome, washington]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCapitals()
    }
    
    func setupCapitals() {
        for capital in capitals {
            mapView.addAnnotation(capital)
        }
    }


}

