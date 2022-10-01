//
//  Config.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-10-01.
//

import Foundation
import UIKit

protocol HasConfigType {
    var config: Config { get }
}

protocol Config {
    var translatesAutoresizeMaskIntoConstraints: Bool { get }
    var textAlignment: NSTextAlignment { get }
    var font: UIFont { get }
}
