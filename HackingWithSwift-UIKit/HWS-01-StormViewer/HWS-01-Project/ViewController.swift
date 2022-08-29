//
//  ViewController.swift
//  HWS-01-Project
//
//  Created by Massimo Savino on 2022-05-17.
//

import UIKit

class ViewController: UITableViewController {
    private struct Constants {
        static let NSSLPrefix = "nssl"
        static let pictureIdentifier = "Picture"
        static let detailVC = "Detail"
        static let title = "Storm Viewer"
    }
    
    var pictures = [String]()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchImages()
    }
    
    func fetchImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        DispatchQueue.main.async {
            let items = try! fm.contentsOfDirectory(atPath: path)
            for item in items {
                if item.hasPrefix(Constants.NSSLPrefix) {
                    self.pictures.append(item)
                }
            }
            self.pictures = self.pictures.sorted { $0 < $1 }
            print(self.pictures)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        count = pictures.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pictureIdentifier, for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.detailVC) as? DetailViewController {
            vc.selectedImage = vc.pictured(photoNumber: indexPath.row, allImageCount: pictures.count)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

