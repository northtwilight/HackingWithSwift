//
//  UIView+extension.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-10-01.
//

import Foundation
import UIKit

extension UIView {
    func roundOffCorners() {
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.systemPurple.cgColor
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
}
