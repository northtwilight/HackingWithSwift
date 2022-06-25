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
        
    }
    
    var viewModel = ViewModel()
    
    var allWords: [String] = [String]()
    var usedWords: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
            if allWords.isEmpty {
                allWords = ["silkworm"]
            }
        }
        startGame()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(
            title: Constants.enterAnswer,
            message: nil,
            preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func cantSpell(title: String) -> String {
        return "You can't spell that word from \(title)"
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
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
                message: cantSpell(title: title))
        }
        
    }

    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
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
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        if word.utf16.count < 3 {
            return false
        } else if word == title {
            return false
        } else {
            return misspelledRange.location == NSNotFound
        }
    }
}

