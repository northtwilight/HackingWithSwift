//
//  PersonCell.swift
//  HWS-10-NamesToFaces
//
//  Created by Massimo Savino on 2022-06-25.
//

import UIKit

class PersonCell: UICollectionViewCell {
    private struct Constants {
        static let title = "Edit"
        static let message = "Rename or delete?"
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
}
