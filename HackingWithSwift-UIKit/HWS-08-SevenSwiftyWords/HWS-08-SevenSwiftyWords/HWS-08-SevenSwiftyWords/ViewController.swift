//
//  ViewController.swift
//  HWS-08-SevenSwiftyWords
//
//  Created by Massimo Savino on 2022-05-26.
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
    
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    lazy var score = 0 {
        didSet {
            scoreLabel.text = Constants.configureScoreLabel(score: String(score) )
        }
    }
    var level = 1
    
    let buttonsView = UIView()
    
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        formatAndConfigure()
    }
    
    func formatAndConfigure() {
        createSubmitAndClear()
        formatIndividualButtons()
        createButtonsView()
        formatLabels()
        configureTextfield()
        formatConstraints()
        loadLevel()
    }
    
    func levelUp(action: UIAlertAction) {
        DispatchQueue.main.async {
            self.level += 1
            self.solutions.removeAll(keepingCapacity: true)
            self.loadLevel()
            for button in self.letterButtons {
                button.alpha = 0
                let oneSecond = CGFloat(1)
                let noDelay = CGFloat(0)
                UIView.animate(
                    withDuration: oneSecond,
                    delay: noDelay,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 5,
                    options: [],
                    animations: { button.alpha = 1 },
                    completion: { finished in
                        print("Finished button alpha animation.")
                    })
            }
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(
                    title: Constants.wellDone,
                    message: Constants.nextLevel,
                    preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: Constants.letsGo, style: .default, handler: levelUp))
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

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    func createSubmitAndClear() {
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle(Constants.submit, for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle(Constants.clear, for: .normal)
        view.addSubview(clear)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    }
    
    func createButtonsView() {
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
    }
    
    func configureIndividualLabels(
        label: UILabel,
        textAlignment: NSTextAlignment = .right,
        fontSize: CGFloat,
        text: String
    ) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = textAlignment
        view.addSubview(label)
    }
    
    func configureTextfield() {
        currentAnswer.delegate = self
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = Constants.currentAnswerPlaceholder
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: Constants.fortyFour)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
    }
    
    func formatScoreConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    func formatCluesConstraints() {
        NSLayoutConstraint.activate([
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Constants.plusHundred),
            cluesLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: Constants.multiplier,
                constant: Constants.minusHundred)
        ])
    }
    
    func formatAnswersConstraints() {
        NSLayoutConstraint.activate([
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: Constants.minusHundred),
            answersLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: Constants.multiplier,
                constant: Constants.minusHundred),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
        ])
    }
    
    func formatCurrentAnswerConstraints() {
        NSLayoutConstraint.activate([
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: Constants.pointFiveMultiplier),
            currentAnswer.topAnchor.constraint(
                equalTo: cluesLabel.bottomAnchor,
                constant: 20)
        ])
    }
    
    func formatButtonsViewConstraints() {
        NSLayoutConstraint.activate([
            buttonsView.widthAnchor.constraint(equalToConstant: Constants.buttonsViewWidth),
            buttonsView.heightAnchor.constraint(equalToConstant: Constants.buttonsViewHeight),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: Constants.buttonsViewTop),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Constants.buttonsViewBottom)
        ])
        
    }
    
    func formatSubmitConstraints() {
        NSLayoutConstraint.activate([
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.submitCenterX),
            submit.heightAnchor.constraint(equalToConstant: Constants.submitHeight)
        ])
    }
    
    func formatClearConstraints() {
        NSLayoutConstraint.activate([
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.clearCenterX),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: Constants.clearHeight)
        ])
    }
    
    func formatConstraints() {
        formatScoreConstraints()
        formatCluesConstraints()
        formatAnswersConstraints()
        formatCurrentAnswerConstraints()
        formatSubmitConstraints()
        formatClearConstraints()
        formatButtonsViewConstraints()
    }
    
    func formatLabels() {
        let scoreLabel = UILabel()
        configureIndividualLabels(
            label: scoreLabel,
            fontSize: Constants.twentyFour,
            text: Constants.scoreText)
        let cluesLabel = UILabel()
        configureIndividualLabels(
            label: cluesLabel,
            fontSize: Constants.twentyFour,
            text: Constants.clues)
        let answersLabel = UILabel()
        configureIndividualLabels(
            label: answersLabel,
            fontSize: Constants.twentyFour,
            text: Constants.answers)
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        cluesLabel.backgroundColor = .red
        answersLabel.backgroundColor = .blue
        buttonsView.backgroundColor = .green
    }
    
    func formatIndividualButtons() {
        let width = Constants.buttonWidth
        let height = Constants.buttonHeight
        
        // create 20 buttons as a 4x5 grid
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonSize)
                letterButton.setTitle("WWW", for: .normal)
                
                letterButton.frame = CGRect(
                    x: CGFloat(column) * width,
                    y: CGFloat(row) * height,
                    width: width,
                    height: height)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    func levelNumber(level: Int) -> String {
        "level\(level)"
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
            for item in 0 ..< letterButtons.count {
                letterButtons[item].setTitle(letterBits[item], for: .normal)
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
}
