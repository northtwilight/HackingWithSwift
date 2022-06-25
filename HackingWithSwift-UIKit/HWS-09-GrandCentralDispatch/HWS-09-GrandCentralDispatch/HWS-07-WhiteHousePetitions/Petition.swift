//
//  Petition.swift
//  HWS-07-WhiteHousePetitions
//
//  Created by Massimo Savino on 2022-05-25.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
