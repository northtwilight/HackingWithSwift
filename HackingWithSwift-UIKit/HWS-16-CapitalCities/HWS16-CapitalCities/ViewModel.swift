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
        struct Capitals {
            struct London {
                static let title = "Londahn"
                static let latitude = 51.507222
                static let longitude = -0.1275
                static let info = "Home to the 2012 Summer Olympics."
            }
            struct Oslo {
                static let title = "Osl0"
                static let latitude = 59.95
                static let longitude = 10.75
                static let info = "Founded over a thousand years ago."
            }
            struct Paris {
                static let title = "PariZZs"
                static let latitude = 48.8567
                static let longitude = 2.3508
                static let info = "Often called the City of Light."
            }
            struct Rome {
                static let title = "RomA"
                static let latitude = 41.9
                static let longitude = 12.5
                static let info = "Has a whole country inside it."
            }
            struct Washington {
                static let title = "WaRshington"
                static let latitude = 38.895111
                static let longitude = -77.036667
                static let info = "Named after George himself."
            }
        }
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
        title: Constants.Capitals.London.title,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.Capitals.London.latitude,
            longitude: Constants.Capitals.London.longitude),
        info: Constants.Capitals.London.info)
    
    let oslo = Capital(
        title: Constants.Capitals.Oslo.title,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.Capitals.Oslo.latitude,
            longitude: Constants.Capitals.Oslo.longitude),
        info: Constants.osloInfo)
    
    let paris = Capital(
        title: Constants.Capitals.Paris.title,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.Capitals.Paris.latitude,
            longitude: Constants.Capitals.Paris.longitude),
        info: Constants.Capitals.Paris.info)
    
    let rome = Capital(
        title: Constants.Capitals.Rome.title,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.Capitals.Rome.latitude,
            longitude: Constants.Capitals.Rome.longitude),
        info: Constants.romeInfo)
    
    let washington = Capital(
        title: Constants.Capitals.Washington.title,
        coordinate: CLLocationCoordinate2D(
            latitude: Constants.Capitals.Washington.latitude,
            longitude: Constants.Capitals.Washington.longitude),
        info: Constants.Capitals.Washington.info)
    
    public lazy var cities: [Capital] = [london, oslo, paris, rome, washington]
}
