//
//  ViewModel.swift
//  HWS-08-SevenSwiftyWords
//
//  Created by Massimo Savino on 2022-09-27.
//

import Foundation
import UIKit
import Combine

class ViewModel {
    var level = 1
    var solutions = [String]()
    var cluesText = String()
    var answersText = String()
    var letterBits = [String]()
    let triggerLoadLevelSubject = PassthroughSubject<Bool, Never>()
    
    func levelNumber(level: Int) -> String {
        "level\(level)"
    }
    
    
    func loadLevel() {
        DispatchQueue.main.async {
            var clueString = ""
            var solutionString = ""
            
            if let levelFileURL = Bundle.main.url(forResource: self.levelNumber(level: self.level), withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        self.solutions.append(solutionWord)
                        
                        let bits = answer.components(separatedBy: "|")
                        self.letterBits += bits
                    }
                }
            }
            self.cluesText = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self.answersText = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
            self.letterBits.shuffle()
            self.triggerLoadLevelSubject.send(true)
        }
    }
    
    func configureIndividualLabels(
        label: UILabel,
        textAlignment: NSTextAlignment = .right,
        fontSize: CGFloat,
        text: String,
        contentHuggingPriority: UILayoutPriority = UILayoutPriority(1),
        axis: NSLayoutConstraint.Axis = .vertical,
        backgroundColor: UIColor = .white
    ) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = textAlignment
        label.setContentHuggingPriority(contentHuggingPriority, for: axis)
        label.backgroundColor = backgroundColor
    }
}
