//
//  Person.swift
//  HWS-10-NamesToFaces
//
//  Created by Massimo Savino on 2022-06-25.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
