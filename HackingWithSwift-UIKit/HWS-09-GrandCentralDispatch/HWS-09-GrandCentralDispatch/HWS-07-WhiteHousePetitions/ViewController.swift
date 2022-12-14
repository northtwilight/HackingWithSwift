//
//  ViewController.swift
//  HWS-07-WhiteHousePetitions
//
//  Created by Massimo Savino on 2022-05-25.
//

import UIKit

class ViewController: UITableViewController {
    private struct Constants {
        static let identifier = "Cell"
        static let titleGoesHere = "Title goes here"
        static let subtitleGoesHere = "Subtitle goes here"
        
        static let hwsURLString1 = "https://www.hackingwithswift.com/samples/petitions-1.json"
        static let hwsURLString2 = "https://www.hackingwithswift.com/samples/petitions-2.json"
        static let whURLString1 = "https://api.whitehouse.gov/v1/petitions.json?limit.json"
        static let whURLString2 = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        
        static let loadingError = "Loading error"
        static let message = "There was a problem loading the feed; please check your connection and try again"
        static let peopleAPI = "The data comes from the We the People API of the White House"
        static let filterPetitions = "Filter petitions"
        static let enterAKeyword = "Enter a keyword"
    }
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    var creditsButton: UIBarButtonItem!
    
    // MARK: - Lifecycle
    
    @objc func fetchJSON() {

        DispatchQueue.main.async {
            let urlString: String
            if self.navigationController?.tabBarItem.tag == 0 {
                // urlString = Constants.whURLString1
                urlString = Constants.hwsURLString1
            } else {
                // urlString = Constants.whURLString2
                urlString = Constants.hwsURLString2
            }
            DispatchQueue.global(qos: .userInitiated).async {
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        self.parse(json: data)
                        return
                    }
                }
            }
        }
        
        self.performSelector(
            onMainThread: #selector(self.showError),
            with: nil,
            waitUntilDone: false)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Credits",
            style: .plain,
            target: self,
            action: #selector(showCredits))
        
        let filter = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterPetitions))
        
        let reset = UIBarButtonItem(
            title: "Reset",
            style: .plain,
            target: self,
            action: #selector(resetFilter))
        
        reset.tintColor = UIColor.red
        reset.isEnabled = false
        
        navigationItem.leftBarButtonItems = [filter, reset]
    }
    
    // MARK: - Table view methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.isEmpty ? petitions.count : filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath)
        
        
        DispatchQueue.main.async {
            
            let petition: Petition
            if self.filteredPetitions.isEmpty {
                petition = self.petitions[indexPath.row]
            } else {
                petition = self.filteredPetitions[indexPath.row]
            }
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Other methods
    
    func parse(json: Data) {
        DispatchQueue.main.async {
            let decoder = JSONDecoder()
            if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
                self.petitions = jsonPetitions.results
                self.tableView.performSelector(
                    onMainThread: #selector(UITableView.reloadData),
                    with: nil,
                    waitUntilDone: false)
            } else {
                self.performSelector(
                    onMainThread: #selector(self.showError),
                    with: nil,
                    waitUntilDone: false)
            }
        }
        
    }
    
    @objc func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(
                title: Constants.loadingError,
                message: Constants.message,
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
        
    }
    
    // MARK: - ObjC functions
    
    @objc func resetFilter() {
        filteredPetitions.removeAll()
        tableView.reloadData()
        self.navigationItem.leftBarButtonItems?.last?.isEnabled = false
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(
            title: "Credits",
            message: Constants.peopleAPI,
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil))
        present(ac, animated: true)
    }
    
    @objc func filterPetitions() {
        let ac = UIAlertController(
            title: Constants.filterPetitions,
            message: Constants.enterAKeyword,
            preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(
            title: "Submit",
            style: .default) { [weak ac, self] _ in
                guard let keyword = ac?.textFields?[0].text else { return }
                self.filter(keyword)
            }
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    func filter(_ keyword: String) {
        for idx in 0...petitions.count - 1 {
            if petitions[idx].title.lowercased().contains(keyword.lowercased()) {
                filteredPetitions.append(petitions[idx])
            }
        }
        if filteredPetitions.isEmpty {
            let ac = UIAlertController(title: "Error", message: "No match found.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        } else {
            self.navigationItem.leftBarButtonItems?.last?.isEnabled = true
        }
        tableView.reloadData()
    }
}

