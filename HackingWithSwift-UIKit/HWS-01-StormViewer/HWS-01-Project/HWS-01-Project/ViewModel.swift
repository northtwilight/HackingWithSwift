//
//  ViewModel.swift
//  HWS-01-Project
//
//  Created by Massimo Savino on 2022-07-06.
//

import Foundation

protocol ViewModelType {
}

class ViewModel: ViewModelType {
    func setDisplayCount() {
        let defaults = UserDefaults.standard
        if let displayCount = defaults.object(forKey: "count") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let decodedCount = try jsonDecoder.decode([Person].self, from: savedPeople)
                return decodedPeople
            } catch {
                print(Constants.failedToLoad)
            }
        }
    }
}
