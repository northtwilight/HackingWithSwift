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
    }

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    
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
        
        makeAndLayoutLabels()
    }
    
    func makeAndLayoutLabels() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        
        var previous: UILabel?
               
        let labelTuples = [
            (label1, "THESE", UIColor.red),
            (label2, "ARE", UIColor.cyan),
            (label3, "SOME", UIColor.yellow),
            (label4, "AWESOME", UIColor.green),
            (label5, "LABELS", UIColor.orange)
        ]
        
        for label in labelTuples {
            label.0.translatesAutoresizingMaskIntoConstraints = false
            label.0.backgroundColor = label.2
            label.0.text = label.1
            label.0.sizeToFit()
            
            view.addSubview(label.0)
            
            formatLabels(label: label.0, previous: previous)
            previous = label.0
        }
    }
    
    func formatLabels(label: UILabel, previous: UILabel?) {
        let guide = view.safeAreaLayoutGuide
        guard let heightAnchor = guide.owningView?.safeAreaLayoutGuide.heightAnchor else {
            print("Unable to lay out safe area guides")
            return
        }
        label.heightAnchor.constraint(
            equalTo: heightAnchor,
            multiplier: 0.2,
            constant: -10).isActive = true
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if let previous = previous {
            label.topAnchor.constraint(
                equalTo: previous.bottomAnchor, constant: 10).isActive = true
        } else {
            label.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        }
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = makeUpdatedTitle(score: score)
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
        return "\(countries[correctAnswer].uppercased()) :: score: \(score)"
    }
    
    func makeMessageString(score: Int) -> String {
        return "Your score is \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = Constants.correct
            score += 1
        } else {
            title = Constants.wrong
            score -= 1
        }
        let ac = UIAlertController(
            title: title,
            message: makeMessageString(score: score),
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(
            title: Constants.continueDoingStuff,
            style: .default,
            handler: askQuestion))
        present(ac, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

