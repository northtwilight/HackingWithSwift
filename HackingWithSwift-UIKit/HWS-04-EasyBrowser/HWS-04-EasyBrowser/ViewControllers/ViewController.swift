//
//  ViewController.swift
//  HWS-04-EasyBrowser
//
//  Created by Massimo Savino on 2022-05-18.
//

import UIKit
import WebKit

class ViewController: UITableViewController {
    var websites = [
        WebsiteConstants.Sites.appleCom,
        WebsiteConstants.Sites.hackingWithSwiftURL,
        WebsiteConstants.Sites.slashdotURL,
        WebsiteConstants.Sites.hackerNews,
        WebsiteConstants.Sites.lobsters
    ]

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureBars()
    }
    
    func configureBars() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.systemGray
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: UITableView delegate and data source methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WebsiteConstants.cellIdentifier) else {
            print("This cell not laid out")
            return UITableViewCell()
        }
        let URLString = WebsiteConstants.https + websites[indexPath.row]
        cell.textLabel?.text = URLString
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(
            withIdentifier: WebsiteConstants.websiteViewController) as? WebsiteViewController else {
            print("Can't instantiate website VC")
            return
        }
        vc.websites = websites
        vc.currentWebsite = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        websites.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}

