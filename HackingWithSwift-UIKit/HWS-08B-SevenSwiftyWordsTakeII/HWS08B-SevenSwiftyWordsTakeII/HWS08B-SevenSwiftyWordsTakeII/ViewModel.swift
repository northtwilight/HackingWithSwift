//
//  ViewModel.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-09-30.
//

import Foundation
import UIKit

class ViewModel: NSObject {
    func configure(label: UILabel, config: LabelConfig) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: config.fontSize)
        label.text = config.text
        label.textAlignment = config.textAlignment
        label.numberOfLines = 0
        label.setContentHuggingPriority(config.contentHuggingPriority, for: config.axis)
        label.backgroundColor = config.backgroundColor
    }
    
    func configure(textField: UITextField, config: TextFieldConfig) {
        textField.translatesAutoresizingMaskIntoConstraints = config.translatesAutoresizeMaskIntoConstraints
        textField.placeholder = config.placeholder
        textField.textAlignment = config.textAlignment
        textField.font = UIFont.systemFont(ofSize: config.fontSize)
        textField.isUserInteractionEnabled = config.isUserInteractionEnabled
    }
}
