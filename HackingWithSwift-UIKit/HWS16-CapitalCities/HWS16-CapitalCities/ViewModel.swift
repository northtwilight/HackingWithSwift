//
//  ViewModel.swift
//  HWS16-CapitalCities
//
//  Created by Massimo Savino on 2022-08-05.
//

import Foundation
import MapKit
import UIKit

protocol ViewModelType {
    var cities: [Capital] { get }
}
class ViewModel: ViewModelType {
    private struct Constants {
        static let londonInfo = "Home to the 2012 Summer Olympics"
        static let osloInfo = "Founded over a thousand years ago."
        static let parisInfo = "Often called the City of Light"
        static let romeInfo = "Has a whole country inside it."
        static let washingtonInfo = "Named after George himself."
        
        static let londonTitle = "London"
        static let osloTitle = "Oslo"
        static let parisTitle = "PariZZs"
        static let romeTitle = "Rome"
        static let washingtonTitle = "Washington"
        
        static let londonLatitude = 51.507222
        static let osloLatitude = 59.95
        static let parisLatitude = 48.8567
        static let romeLatitude = 41.9
        static let washingtonLatitude = 38.895111
        
        static let londonLongitude = -0.1275
        static let osloLongitude = 10.75
        static let parisLongitude = 2.3508
        static let romeLongitude = 12.5
        static let washingtonLongitude = -77.036667
    }
    
    let london = Capital(
        title: Constants.londonTitle,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.londonLatitude,
            longitude: Constants.londonLongitude),
        info: Constants.londonInfo)
    
    let oslo = Capital(
        title: Constants.osloTitle,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.osloLatitude,
            longitude: Constants.osloLongitude),
        info: Constants.osloInfo)
    
    let paris = Capital(
        title: Constants.parisTitle,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.parisLatitude,
            longitude: Constants.parisLongitude),
        info: Constants.parisInfo)
    
    let rome = Capital(
        title: Constants.romeTitle,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.romeLatitude,
            longitude: Constants.romeLongitude),
        info: Constants.romeInfo)
    
    let washington = Capital(
        title: Constants.washingtonTitle,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.washingtonLatitude,
            longitude: Constants.washingtonLongitude),
        info: Constants.washingtonInfo)
    
    lazy var cities: [Capital] = [london, oslo, paris, rome, washington]
}
