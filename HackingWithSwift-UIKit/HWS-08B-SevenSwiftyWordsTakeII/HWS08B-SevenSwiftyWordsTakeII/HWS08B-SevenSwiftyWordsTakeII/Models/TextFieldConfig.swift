//
//  TextFieldConfig.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-10-01.
//

import Foundation
import UIKit

struct TextFieldConfig: Config {
    let translatesAutoresizeMaskIntoConstraints: Bool = false
    let textAlignment: NSTextAlignment
    let font: UIFont
    let fontSize: CGFloat
    let placeholder: String
    let isUserInteractionEnabled: Bool
}
