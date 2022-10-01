//
//  LabelConfig.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-10-01.
//

import Foundation
import UIKit


struct LabelConfig: Config {
    let translatesAutoresizeMaskIntoConstraints: Bool = false
    let textAlignment: NSTextAlignment
    let font: UIFont
    let label: UILabel
    let text: String
    let contentHuggingPriority: UILayoutPriority
    let axis: NSLayoutConstraint.Axis
    let backgroundColor: UIColor
}
