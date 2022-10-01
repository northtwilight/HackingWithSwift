//
//  ViewController.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-09-30.
//

import UIKit

class ViewController: UIViewController {
    private struct Constants {
        static let scoreText = "Score: 0"
        
        static let clues = "CLUES"
        static let answers = "ANSWERS"
        static let submit = "SUBMIT"
        static let clear = "CLEAR"
        static let currentAnswerPlaceholder = "Tap letters to guess"
        static let multiplier = 0.6
        static let pointFiveMultiplier = 0.5
        static let pointFourMultiplier = 0.4
        
        static let twentyFour = CGFloat(24)
        static let fortyFour = CGFloat(44)
        static let plusHundred = CGFloat(100)
        static let minusHundred = CGFloat(-100)
        static let buttonsViewWidth = CGFloat(750)
        static let buttonsViewHeight = CGFloat(320)
        static let buttonsViewTop = CGFloat(20)
        static let buttonsViewBottom = CGFloat(-20)
        static let submitCenterX = CGFloat(-100)
        static let submitHeight = CGFloat(44)
        static let clearCenterX = CGFloat(100)
        static let clearHeight = submitHeight
        static let buttonWidth = CGFloat(150)
        static let buttonHeight = CGFloat(80)
        static let buttonSize = CGFloat(36)
        
        static let wellDone = "Well done!"
        static let nextLevel = "Are you ready for the next level?"
        static let letsGo = "Let's go!"
        static func configureScoreLabel(score: String) -> String {
            "Score: \(score)"
        }
    }
    
    var viewModel = ViewModel()
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        let scoreConfig = LabelConfig(
            textAlignment: .right,
            font: UIFont.systemFont(ofSize: Constants.twentyFour),
            label: scoreLabel,
            text: Constants.scoreText,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: .darkGray)
                
        viewModel.configure(label: scoreLabel, config: scoreConfig)
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        let cluesConfig = LabelConfig(
            textAlignment: .left,
            font: UIFont.systemFont(ofSize: Constants.twentyFour),
            label: cluesLabel,
            text: Constants.clues,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: .systemRed)
        view.addSubview(cluesLabel)
                
        answersLabel = UILabel()
        let answerConfig = LabelConfig(
            textAlignment: .right,
            font: UIFont.systemFont(ofSize: Constants.fortyFour),
            label: answersLabel,
            text: Constants.answers,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: .systemBlue)
        view.addSubview(answersLabel)
                
        currentAnswer = UITextField()
        let currentAnswerConfig = TextFieldConfig(
            textAlignment: .center,
            font: UIFont.systemFont(ofSize: Constants.fortyFour),
            placeholder: Constants.currentAnswerPlaceholder,
            isUserInteractionEnabled: false)
        
        viewModel.configure(textField: currentAnswer, config: currentAnswerConfig)
        view.addSubview(currentAnswer)
        
        let labelTuples: [(UILabel, LabelConfig)] = [
            (scoreLabel, scoreConfig),
            (cluesLabel, cluesConfig),
            (answersLabel, answerConfig)]
        
        for tuple in labelTuples {
            let label = tuple.0
            let config = tuple.1
            viewModel.configure(label: label, config: config)
            view.addSubview(label) }
        
        let submit = UIButton(type: .system)
        makeControl(button: submit, title: Constants.submit, action: #selector(submitTapped))
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        makeControl(button: clear, title: Constants.clear, action: #selector(clearTapped))
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.backgroundColor = .systemGreen
        
        view.addSubview(buttonsView)
        
        activateConstraints(
            scoreLabel: scoreLabel,
            cluesLabel: cluesLabel,
            answersLabel: answersLabel,
            currentAnswer: currentAnswer,
            submit: submit,
            clear: clear,
            buttonsView: buttonsView)
        
        makeAnswerGridButtons(buttonsView: buttonsView)
    }
    
    func makeControl(button: UIButton, title: String, action: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(
            self,
            action: action,
            for: .touchUpInside)
    }
    
    func activateConstraints(
        scoreLabel: UILabel,
        cluesLabel: UILabel,
        answersLabel: UILabel,
        currentAnswer: UITextField,
        submit: UIButton,
        clear: UIButton,
        buttonsView: UIView) {
            NSLayoutConstraint.activate([
                scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
                
                // Pin the top of the clues label to the bottom of the score label
                cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                
                // Pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
                cluesLabel.leadingAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: Constants.plusHundred),
                
                // Make the clues label 60% of the width of our layout margins, minus 100
                cluesLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: Constants.multiplier,
                    constant: Constants.minusHundred),
                
                // Also, pin the top of the answers label to the bottom of the score label
                answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                
                // Make the answers label stick to the trailing edge of our layour margins, minus 100
                answersLabel.trailingAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: Constants.minusHundred),
                
                // Make the answers label take up 40% of the available space, minus 100
                answersLabel.widthAnchor.constraint(
                    equalTo: view.layoutMarginsGuide.widthAnchor,
                    multiplier: Constants.pointFourMultiplier,
                    constant: Constants.minusHundred),
                
                // Make the answers label match the height of the clues label
                answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
                
                // current answer textField
                currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.pointFiveMultiplier),
                currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: Constants.buttonsViewTop),
                
                // submit button
                submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
                submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.minusHundred),
                submit.heightAnchor.constraint(equalToConstant: Constants.fortyFour),
                
                // clear button
                clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.plusHundred),
                clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
                clear.heightAnchor.constraint(equalToConstant: Constants.fortyFour),
                
                // buttonsView constraints
                buttonsView.widthAnchor.constraint(equalToConstant: Constants.buttonsViewWidth),
                buttonsView.heightAnchor.constraint(equalToConstant: Constants.buttonsViewHeight),
                buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: Constants.buttonsViewTop),
                buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Constants.buttonsViewBottom),
            ])
    }
    
    func makeAnswerGridButtons(buttonsView: UIView) {
        // button grid setup
        let width = 150
        let height = 80

        // create 20 buttons as a 4 x 5 grid
        for row in 0 ..< 4 {
            for column in 0 ..< 5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // give the button some temporary text so we can see it onscreen
                letterButton.setTitle("WWW", for: .normal)
                
                // calculate the frame of this button using its column and row
                let frame = CGRect(
                    x: column * width,
                    y: row * height,
                    width: width,
                    height: height)
                letterButton.frame = frame
                
                // add it to the buttons view
                buttonsView.addSubview(letterButton)
                
                // and also to our letterButtons array
                letterButtons.append(letterButton)
                letterButton.addTarget(
                    self,
                    action: #selector(letterTapped),
                    for: .touchUpInside)
            }
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] =  answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(
                    title: "Well done!",
                    message: "Are you ready for the next level?",
                    preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go", style: .default))
                present(ac, animated: true)
            }
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
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
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
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

