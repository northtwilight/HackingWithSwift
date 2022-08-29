//
//  ViewController.swift
//  HWS-02-GuessTheFlag
//
//  Created by Massimo Savino on 2022-05-17.
//

import UIKit

class ViewController: UIViewController {
    private struct Constants {
        static let correct = "Correct"
        static let wrong = "Wrong"
        static let continueDoingStuff = "Continue"
        static let maxRound = 10
        static let finalTitle = "This is the final round."
        static let OK = "OK"
    }

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var currentRoundLabel: UILabel!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    private var currentRound = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
        
        countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us"
        ]
        askQuestion()
        print(countries)
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = makeUpdatedTitle(score: score)
        currentRound += 1
        currentRoundLabel.text = makeRoundString(currentRound: currentRound)
    }
    
    func styleButtons() {
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func makeUpdatedTitle(score: Int) -> String {
        "\(countries[correctAnswer].uppercased()) :: score: \(score)"
    }
    
    func makeMessageString(score: Int) -> String {
        "Your score is \(score)"
    }
    
    func makeRoundString(currentRound: Int) -> String {
        "The present round is \(currentRound)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if currentRound < Constants.maxRound {
            if sender.tag == correctAnswer {
                title = Constants.correct
                score += 1
            } else {
                title = Constants.wrong
                score -= 1
            }
            let ac = UIAlertController(
                title: title,
                message: makeMessageString(score: score), preferredStyle: .alert)
            ac.addAction(UIAlertAction(
                title: Constants.continueDoingStuff,
                style: .default,
                handler: askQuestion))
            present(ac, animated: true)
        } else {
            let finalAC = UIAlertController(
                title: Constants.finalTitle,
                message: makeMessageString(score: score),
                preferredStyle: .alert)
            finalAC.addAction(UIAlertAction(title: Constants.OK, style: .default))
            present(finalAC, animated: true)
            currentRound = 0
            score = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

