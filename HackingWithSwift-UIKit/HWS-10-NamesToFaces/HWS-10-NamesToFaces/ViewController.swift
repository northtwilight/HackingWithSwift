//
//  ViewController.swift
//  HWS-10-NamesToFaces
//
//  Created by Massimo Savino on 2022-06-25.
//

import UIKit

class ViewController:
    UICollectionViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    private struct Constants {
        static let personReuseIdentifier = "Person"
        static let renamePerson = "Rename Person"
        static let editPerson = "Edit Person"
        static let message = "Did you want to rename of delete this person?"
        static let cancel = "Cancel"
        static let rename = "Rename"
        static let delete = "Delete"
    }
    
    var people = [Person]()

    lazy var isCameraEnabled: Bool = UIImagePickerController.isSourceTypeAvailable(.camera)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPerson))
    }
    
    func calibrateDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pid")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return people.count
//        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.personReuseIdentifier, for: indexPath) as? PersonCell else {
            // Failed to obtain a PersonCell - crash immediately
            fatalError("Unable to dequeue PersonCell.")
        }
        let person = people[indexPath.item]
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ac = UIAlertController(
            title: Constants.editPerson,
            message: Constants.message,
            preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: Constants.cancel, style: .cancel))
        
        ac.addAction(UIAlertAction(title: Constants.rename, style: .default, handler: { action in
            self.renamePerson(ac: ac, indexPath: indexPath)
        }))
        
        ac.addAction(UIAlertAction(title: Constants.delete, style: .default, handler: { action in
            self.deletePerson(collectionView, indexPath: indexPath)
        }))
        present(ac, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
    
    @objc func addNewPerson(isCameraAvailable: Bool) {
        let picker = UIImagePickerController()
        if isCameraAvailable {
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func renamePerson(ac: UIAlertController, indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(
            title: Constants.renamePerson,
            message: nil,
            preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            self?.collectionView.reloadData()
        })
        present(ac, animated: true)
    }
    
    @objc func deletePerson(_ collectionView: UICollectionView, indexPath: IndexPath) {
        people.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}

