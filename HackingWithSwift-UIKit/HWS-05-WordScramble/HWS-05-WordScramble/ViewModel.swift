//
//  ViewModel.swift
//  HWS-05-WordScramble
//
//  Created by Massimo Savino on 2022-05-21.
//

import Foundation

class ViewModel: NSObject {
    private struct Constants {
        static let wordNotPossible = "Word not possible"
        static let silkworm = "silkworm"
        static let start = "start"
        static let txt = "txt"
        static let carriageReturn = "\n"
        static let cellIdentifier = "Cell"
        static let en = "en"
    }
    
    var allWords: [String] = [String]()
    var usedWords: [String] = [String]()
    
    func workoutAllWords() {
        if let startWordsURL = Bundle.main.url(forResource: Constants.start, withExtension: Constants.txt) {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: Constants.carriageReturn)
            }
            if allWords.isEmpty { allWords = [Constants.silkworm] }
        }
    }
    func cantSpell(title: String) -> String {
        return "You can't spell that word from \(title)"
    }
}
