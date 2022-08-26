//
//  Capital.swift
//  HWS16-CapitalCities
//
//  Created by Massimo Savino on 2022-08-04.
//

import Foundation
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
