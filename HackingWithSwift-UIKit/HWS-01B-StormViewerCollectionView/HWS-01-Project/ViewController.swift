//
//  ViewController.swift
//  HWS-01-Project
//
//  Created by Massimo Savino on 2022-05-17.
//

import UIKit

class ViewController: UICollectionViewController {
    private struct Constants {
        static let NSSLPrefix = "nssl"
        static let pictureIdentifier = "Picture"
        static let customCell = "CustomCell"
        static let cell = "Cell"
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
            self.collectionView.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(#file) \(#function) has count of \(pictures.count)")
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.customCell, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Not able to free up and dequeue a custom collection view cell, dying off now..")
        }
        let picture = pictures[indexPath.item]
        cell.titleLabel?.text = picture
        cell.imageView?.image = UIImage(named: picture)
        cell.imageView?.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        cell.imageView?.layer.borderWidth = 4
        cell.imageView?.layer.cornerRadius = 6
        cell.layer.cornerRadius = 7

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.detailVC) as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.selectedImageText = vc.pictured(photoNumber: indexPath.item + 1, allImageCount: pictures.count)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

