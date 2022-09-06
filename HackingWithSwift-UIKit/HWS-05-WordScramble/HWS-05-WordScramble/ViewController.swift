//
//  ViewController.swift
//  HWS-05-WordScramble
//
//  Created by Massimo Savino on 2022-05-21.
//

import Foundation
import UIKit

class ViewController: UITableViewController {
    private struct Constants {
        static let enterAnswer = "Enter answer"
        static let wordNotRecognised = "Word not recognised"
        static let youCant = "You can't just make them up, you know!"
        static let wordUsedAlready = "Word used already"
        static let beMore = "Be more original!"
        static let wordNotPossible = "Word not possible"
        static let silkworm = "silkworm"
        static let start = "start"
        static let txt = "txt"
        static let carriageReturn = "\n"
        static let submit = "Submit"
        static let cellIdentifier = "Cell"
        static let en = "en"
    }

    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForAnswer))
        
        viewModel.workoutAllWords()
        startGame()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(
            title: Constants.enterAnswer,
            message: nil,
            preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: Constants.submit, style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        // Solution for the bug in the official project -
        // Ensures we only use the lower case word in all cases
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    viewModel.usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    showErrorMessage(
                        title: Constants.wordNotRecognised,
                        message: Constants.youCant)
                }
            } else {
                showErrorMessage(
                    title: Constants.wordUsedAlready,
                    message: Constants.beMore)
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(
                title: Constants.wordNotPossible,
                message: viewModel.cantSpell(title: title))
        }
        
    }

    @objc func startGame() {
        title = viewModel.allWords.randomElement()
        viewModel.usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.usedWords[indexPath.row]
        return cell
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(
            title: "OK",
            style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !viewModel.usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: Constants.en)
        if word.utf16.count < 3 {
            return false
        } else if word == title {
            return false
        } else {
            return misspelledRange.location == NSNotFound
        }
    }
}

