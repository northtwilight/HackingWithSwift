//
//  LabelConfig.swift
//  HWS-08-SevenSwiftyWords
//
//  Created by Massimo Savino on 2022-09-29.
//

import Foundation
import UIKit

struct LabelConfig {
    let label: UILabel
    let fontSize: CGFloat
    let text: String
    let contentHuggingPriority: UILayoutPriority
    let axis: NSLayoutConstraint.Axis
    let backgroundColor: UIColor
}
