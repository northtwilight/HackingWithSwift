//
//  ViewModel.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-09-30.
//

import Foundation
import UIKit
import Combine

class ViewModel: NSObject {
    private struct Constants {
        static let scoreText = "Score: 0"
        
        static let clues = "CLUES"
        static let answers = "ANSWERS"
        
        static let currentAnswerPlaceholder = "Tap letters to guess"
        
        static let twentyFour = CGFloat(24)
        static let fortyFour = CGFloat(44)
    }
    
    var level = 1
    
    var letterButtons = [UIButton]()
    var solutions = [String]()
    
    var cluesText = String()
    
    private let cluesSubject = CurrentValueSubject<String, Never>("")
    lazy var cluesPublisher: AnyPublisher<String, Never> = {
        cluesSubject.eraseToAnyPublisher()
    }()
    
    var answersText = String()
    
    private let answersSubject = CurrentValueSubject<String, Never>("")
    lazy var answersPublisher: AnyPublisher<String, Never> = {
        answersSubject.eraseToAnyPublisher()
    }()
    
    let scoreConfig = LabelConfig(
        textAlignment: .right,
        font: UIFont.systemFont(ofSize: Constants.twentyFour),
        text: Constants.scoreText,
        contentHuggingPriority: UILayoutPriority(1),
        axis: .vertical,
        backgroundColor: .darkGray)
    
    let cluesConfig = LabelConfig(
        textAlignment: .left,
        font: UIFont.systemFont(ofSize: Constants.twentyFour),
        text: Constants.clues,
        contentHuggingPriority: UILayoutPriority(1),
        axis: .vertical,
        backgroundColor: .systemRed)
    
    let answerConfig = LabelConfig(
        textAlignment: .right,
        font: UIFont.systemFont(ofSize: Constants.fortyFour),
        text: Constants.answers,
        contentHuggingPriority: UILayoutPriority(1),
        axis: .vertical,
        backgroundColor: .systemBlue)
    
    let currentAnswerConfig = TextFieldConfig(
        textAlignment: .center,
        font: UIFont.systemFont(ofSize: Constants.fortyFour),
        placeholder: Constants.currentAnswerPlaceholder,
        isUserInteractionEnabled: false)
    
    func configure(label: UILabel, config: LabelConfig) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = config.font
        label.text = config.text
        label.textAlignment = config.textAlignment
        label.numberOfLines = 0
        label.setContentHuggingPriority(config.contentHuggingPriority, for: config.axis)
        label.backgroundColor = config.backgroundColor
        
        label.roundOffCorners()
    }
    
    func configure(textField: UITextField, config: TextFieldConfig) {
        textField.translatesAutoresizingMaskIntoConstraints = config.translatesAutoresizeMaskIntoConstraints
        textField.placeholder = config.placeholder
        textField.textAlignment = config.textAlignment
        textField.font = config.font
        textField.isUserInteractionEnabled = config.isUserInteractionEnabled
        
        textField.roundOffCorners()
    }
    
    func loadLevel() {
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: levelNumber(level: level), withExtension: "txt") {
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
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        cluesText = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersText = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        cluesSubject.send(cluesText)
        answersSubject.send(answersText)
        print("cluesText: \(cluesText)")
        print("answersText: \(answersText)")
        letterBits.shuffle()
        
        if letterBits.count == letterButtons.count {
            for iteration in 0 ..< letterButtons.count {
                letterButtons[iteration].setTitle(letterBits[iteration], for: .normal)
            }
        }
    }
    
    func levelNumber(level: Int) -> String {
        "level\(level)"
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for button in letterButtons {
            button.isHidden = false
        }
    }
}
