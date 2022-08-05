//
//  ViewController.swift
//  HWS16-CapitalCities
//
//  Created by Massimo Savino on 2022-08-04.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    func setupViewModel() {
        let viewModel = ViewModel()
        for capital in viewModel.cities {
            mapView.addAnnotation(capital)
        }
    }
}

