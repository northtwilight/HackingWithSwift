//
//  ViewController.swift
//  HWS-11-Instafilter
//
//  Created by Massimo Savino on 2022-07-09.
//
import Combine
import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private struct Constants {
        static let pageTitle = "YACIFP"
        static let saveError = "Save error"
        static let saved = "Saved!"
        static let alteredMessage = "Your altered image has been saved to your photos."
        static let chooseFilter = "Choose filter"
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensitySlider: UISlider!
    @IBOutlet weak var changeFilterButton: UIButton!
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    enum CIFilterAction: String, CaseIterable {
        case distortion = "CIBumpDistortion"
        case gaussian = "CIGaussianBlur"
        case pixellate = "CIPixellate"
        case sepia = "CISepiaTone"
        case twirl = "CITwirlDistortion"
        case unsharp = "CIUnsharpMask"
        case vignette = "CIVignette"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.pageTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: CIFilterAction.sepia.rawValue)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: Constants.saveError, message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: Constants.saved, message: Constants.alteredMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func setAlertAction(
        alertController: UIAlertController,
        title: String,
        handler: @escaping ((UIAlertAction) -> Void) ) {
            alertController.addAction(UIAlertAction(title: title, style: .default, handler: handler))
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        currentFilter = CIFilter(name: actionTitle)
        changeFilterButton.setTitle(actionTitle, for: .normal)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: Any) {
        let ac = UIAlertController(
            title: Constants.chooseFilter,
            message: nil,
            preferredStyle: .actionSheet)
        
        for filter in CIFilterAction.allCases {
            setAlertAction(
                alertController: ac,
                title: filter.rawValue,
                handler: setFilter)
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "You no image", message: "No image man", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        UIImageWriteToSavedPhotosAlbum(
            image,
            self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)),
            nil)
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        guard let image = currentFilter.outputImage else { return }

        let inputKeys = currentFilter.inputKeys
        let filterKeys: [String: Any] = [
            kCIInputIntensityKey: intensitySlider.value,
            kCIInputRadiusKey: intensitySlider.value * 200,
            kCIInputScaleKey: intensitySlider.value * 10,
            kCIInputCenterKey: CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2)
        ]
        for key in inputKeys {
            if filterKeys[key] != nil { currentFilter.setValue(filterKeys[key], forKey: key)}
        }
        
        if let cgimg = context.createCGImage(image, from: image.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
}

