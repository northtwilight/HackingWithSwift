//
//  ViewController.swift
//  HWS-6B-AwesomeLabels
//
//  Created by Massimo Savino on 2022-09-26.
//

import UIKit

class ViewController: UIViewController {
    private struct Constants {
        static func vflHorizontal(label: String) -> String {
            "H:|[\(label)]"
        }
        static let vflVertical = "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
        static let newVFLVertical = "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeAndLayoutLabels()
    }

    
    func makeAndLayoutLabels() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let label4 = UILabel()
        let label5 = UILabel()
        
        var previous: UILabel?
               
        let labelTuples = [
            (label1, "THESE", UIColor.red),
            (label2, "ARE", UIColor.cyan),
            (label3, "SOME", UIColor.yellow),
            (label4, "AWESOME", UIColor.green),
            (label5, "LABELS", UIColor.orange)
        ]
        
        for label in labelTuples {
            label.0.translatesAutoresizingMaskIntoConstraints = false
            label.0.backgroundColor = label.2
            label.0.text = label.1
            label.0.sizeToFit()
            
            view.addSubview(label.0)
            
            if label.1.contains("THESE") {
                previous = nil
            }
            
            formatLabels(label: label.0, previous: previous)
            previous = label.0
        }
        /*
        let viewsDictionary = [
            "label1": label1,
            "label2": label2,
            "label3": label3,
            "label4": label4,
            "label5": label5
        ]
        for label in viewsDictionary.keys {
            view.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat: Constants.vflHorizontal(label: label),
                    options: [],
                    metrics: nil,
                    views: viewsDictionary))
            
            let metrics = ["labelHeight": 88]
            
            view.addConstraints(
                NSLayoutConstraint.constraints(
                    withVisualFormat:
                        // "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|",
                    "V:|[label1(labelHeight@999)]-[label2(labelHeight@999)]-[label3(labelHeight@999)]-[label4(labelHeight@999)]-[label5(labelHeight@999)]->=10-|",
                        // Constants.newVFLVertical, // Constants.vflVertical,
                    options: [],
                    metrics: metrics,
                    views: viewsDictionary))
        }
         */
    }
    
    func formatLabels(label: UILabel, previous: UILabel?) {
//        let guide = view.safeAreaLayoutGuide
//        guard let heightAnchor = guide.owningView?.safeAreaLayoutGuide.heightAnchor else {
//            print("Unable to lay out safe area guides")
//            return
//        }
        
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if let previous = previous {
            label.topAnchor.constraint(
                equalTo: previous.bottomAnchor, constant: 10).isActive = true
        } else {
            label.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        }
    }

}

