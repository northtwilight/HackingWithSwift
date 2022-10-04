//
//  ViewController.swift
//  HWS08B-SevenSwiftyWordsTakeII
//
//  Created by Massimo Savino on 2022-09-30.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private struct Constants {
        static let submit = "SUBMIT"
        static let clear = "CLEAR"
        
        static let multiplier = 0.6
        static let pointFiveMultiplier = 0.5
        static let pointFourMultiplier = 0.4
        
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
    var scoreLabel: UILabel!
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    
    var currentAnswer: UITextField!
    var cancellables = Set<AnyCancellable>()
    var activatedButtons = [UIButton]()
    
    
    var score = 0 {
        didSet {
            scoreLabel.text = Constants.configureScoreLabel(score: String(self.score))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadLevel()
        subscribeToVM()
    }
    
    func configureLabels() {
        let labelTuples: [(UILabel, LabelConfig)] = [
            (scoreLabel, viewModel.scoreConfig),
            (cluesLabel, viewModel.cluesConfig),
            (answersLabel, viewModel.answerConfig)]
        
        for tuple in labelTuples {
            let label = tuple.0
            let config = tuple.1
            viewModel.configure(label: label, config: config)
            view.addSubview(label) }
        
        
    }
    
    func configureButtons(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        makeControl(button: button, title: title, action: action)
        return button
    }
    
    func configureButtonsView() -> UIView {
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.backgroundColor = .systemGreen
        buttonsView.roundOffCorners()
        
        makeAnswerGridButtons(buttonsView: buttonsView)
        return buttonsView
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        cluesLabel = UILabel()
        answersLabel = UILabel()
        configureLabels()
        
        currentAnswer = UITextField()
        viewModel.configure(textField: currentAnswer, config: viewModel.currentAnswerConfig)
        
        view.addSubview(currentAnswer)
        
        let submit = configureButtons(title: Constants.submit, action: #selector(submitTapped))
        view.addSubview(submit)
        
        let clear = configureButtons(title: Constants.clear, action: #selector(clearTapped))
        view.addSubview(clear)
        
        let buttonsView = configureButtonsView()
        view.addSubview(buttonsView)
        
        activateConstraints(
            scoreLabel: scoreLabel,
            cluesLabel: cluesLabel,
            answersLabel: answersLabel,
            currentAnswer: currentAnswer,
            submit: submit,
            clear: clear,
            buttonsView: buttonsView)
    }
    
    func subscribeToVM() {
        viewModel.cluesPublisher.sink { [weak self] cluesText in
           self?.cluesLabel.text = cluesText
        }.store(in: &cancellables)
        
        viewModel.answersPublisher.sink { [weak self] answersText in
           self?.answersLabel.text = answersText
        }.store(in: &cancellables)
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
                viewModel.letterButtons.append(letterButton)
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
        if let solutionPosition = viewModel.solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] =  answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            print("answersLabel.text = \(answersLabel.text)")
            currentAnswer.text = ""
            score += 1

            if answersLabel.text?.contains("letters") == false {
                print("answersLabel.text doesn't contain 'letters', triggered ")
                let ac = UIAlertController(
                    title: "Well done!",
                    message: "Are you ready for the next level?",
                    preferredStyle: .alert)
                ac.addAction(UIAlertAction(
                    title: "Let's go",
                    style: .default,
                    handler: viewModel.levelUp(action:)))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(
                title: "Oh damn!",
                message: "Wrong answer!",
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Uh oh!!", style: .default))
            ac.addAction(UIAlertAction(title: "Clear", style: .destructive) {[weak self]  _ in
                print("About to clear via \(#file) & \(#function) calling clearTappedAction")
                self?.clearTappedAction()
            })
            present(ac, animated: true)
            score -= 1
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        clearTappedAction()
    }
    
    private func clearTappedAction() {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
}

