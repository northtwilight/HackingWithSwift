//
//  ViewController.swift
//  HWS-08-SevenSwiftyWords
//
//  Created by Massimo Savino on 2022-05-26.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet var cluesLabel: UILabel!
    @IBOutlet var answersLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var currentAnswer: UITextField!
    
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
    
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var cancellables = Set<AnyCancellable>()
    
    lazy var score = 0 {
        didSet {
            scoreLabel.text = Constants.configureScoreLabel(score: String(score) )
        }
    }
    
    let buttonsView = UIView()
    
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)
    
    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLoadLevelTrigger()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        loadLetterButtons()
        // guard let currentAnswer = self.currentAnswer else { print("This is really fucked"); return }
        formatAndConfigure()
    }

    
    func loadLetterButtons() {
        for subview in view.subviews where subview.tag == 1001 {
            if let bttn = subview as? UIButton {
                letterButtons.append(bttn)
                bttn.addTarget(
                    self,
                    action: #selector(letterTapped),
                    for: .touchUpInside)
            }
        }
    }
    
    func formatAndConfigure() {
        viewModel.loadLevel()
        
        formatLabels()
        configureTextfield()
        formatConstraints()
        
        createButtonsView()
        
        createSubmitAndClear(
            button: submit,
            title: Constants.submit,
            action: #selector(submitTapped))
        
        createSubmitAndClear(
            button: clear,
            title: Constants.clear,
            action: #selector(clearTapped))
        
        formatIndividualButtons()
        
        
        
        
        
        viewModel.loadLevel()
    }
    
    @IBAction func resignTextField(_ sender: Any) {
        currentAnswer.resignFirstResponder()
    }
    
    func subscribeToLoadLevelTrigger() {
        viewModel.triggerLoadLevelSubject.sink { [weak self] bool in
            guard let self = self else { return }
            if self.viewModel.letterBits.count == self.letterButtons.count {
                for item in 0 ..< self.letterButtons.count {
                    self.letterButtons[item].setTitle(self.viewModel.letterBits[item], for: .normal)
                }
            }
        }.store(in: &cancellables)
    }
    
    func levelUp(action: UIAlertAction) {
        DispatchQueue.main.async {
            self.viewModel.level += 1
            self.viewModel.solutions.removeAll(keepingCapacity: true)
            self.viewModel.loadLevel()
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
    
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        if let solutionPosition = viewModel.solutions.firstIndex(of: answerText) {
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
    
    @IBAction func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func createSubmitAndClear(button: UIButton, title: String, action: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        // view.addSubview(button)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func createButtonsView() {
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        // view.addSubview(buttonsView)
    }
    

    
    func configureTextfield() {
        guard self.currentAnswer != nil else { print("This is well and truly blown in \(#function)!"); return }
        // guard let currentAnswer = self.currentAnswer else { print("This is ,mkklkl"); return // }
//        if self.currentAnswer == nil {
//            self.currentAnswer = UITextField()
//        }
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = Constants.currentAnswerPlaceholder
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: Constants.fortyFour)
        currentAnswer.isUserInteractionEnabled = false
        // view.addSubview(currentAnswer)
    }
    
    func formatConstraints() {
        guard let scoreLabel = self.scoreLabel,
              let cluesLabel = self.cluesLabel,
              let answersLabel = self.answersLabel else {
            print("\(#file) & \(#function) - failed to setup labels")
            return
        }
        NSLayoutConstraint.activate([
            // Score constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // Clues constraints
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Constants.plusHundred),
            cluesLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: Constants.multiplier,
                constant: Constants.minusHundred),
            
            // Answers constraints
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: Constants.minusHundred),
            answersLabel.widthAnchor.constraint(
                equalTo: view.layoutMarginsGuide.widthAnchor,
                multiplier: Constants.multiplier,
                constant: Constants.minusHundred),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // Current answer constraints
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: Constants.pointFiveMultiplier),
            currentAnswer.topAnchor.constraint(
                equalTo: cluesLabel.bottomAnchor,
                constant: 20),
            
            // Submit button constraints
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.submitCenterX),
            submit.heightAnchor.constraint(equalToConstant: Constants.submitHeight),

            // Clear button constraints
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.clearCenterX),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: Constants.clearHeight),
            
            // Buttons view constraints
            buttonsView.widthAnchor.constraint(equalToConstant: Constants.buttonsViewWidth),
            buttonsView.heightAnchor.constraint(equalToConstant: Constants.buttonsViewHeight),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: Constants.buttonsViewTop),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: Constants.buttonsViewBottom)
        ])
    }
    
    func formatLabels() {
        let scoreLabel = UILabel()
        let scoreConfig = LabelConfig(
            label: scoreLabel,
            fontSize: Constants.twentyFour,
            text: Constants.scoreText,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: UIColor.red)
        
        let cluesLabel = UILabel()
        let cluesConfig = LabelConfig(
            label: cluesLabel,
            fontSize: Constants.twentyFour,
            text: Constants.clues,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: UIColor.blue)
        
        let answersLabel = UILabel()
        let answersConfig = LabelConfig(
            label: answersLabel,
            fontSize: Constants.twentyFour,
            text: Constants.answers,
            contentHuggingPriority: UILayoutPriority(1),
            axis: .vertical,
            backgroundColor: UIColor.gray)
        
        let labels = [
            (scoreLabel, scoreConfig),
            (cluesLabel, cluesConfig),
            (answersLabel, answersConfig)]
        
        for (label, config) in labels {
            viewModel.configureIndividualLabels(
                label: label,
                fontSize: Constants.twentyFour,
                text: config.text)
            // view.addSubview(label)
        }
        
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
                letterButton.backgroundColor = UIColor.systemOrange
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func delegationSetting() {
        currentAnswer.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentAnswer.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
