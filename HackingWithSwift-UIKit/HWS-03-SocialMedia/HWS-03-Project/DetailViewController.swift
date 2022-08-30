//
//  DetailViewController.swift
//  HWS-01-Project
//
//  Created by Massimo Savino on 2022-05-17.
//

import UIKit

class DetailViewController: UIViewController {
    private struct Constants {
        static let noImageFound = "No image found"
        static let imageNameError = "Can't find image's description, exiting early"
        static let noSelectedImageSet = "No selected image set"
    }
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedImageText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func pictured(photoNumber: Int, allImageCount: Int) -> String {
        "Picture \(photoNumber) of \(allImageCount)"
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print(Constants.noImageFound)
            return
        }
        guard let description = imageView.image?.description else {
            print(Constants.imageNameError)
            return
        }
        guard let imageToLoad = selectedImage else {
            print(Constants.noSelectedImageSet)
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageToLoad, description], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
