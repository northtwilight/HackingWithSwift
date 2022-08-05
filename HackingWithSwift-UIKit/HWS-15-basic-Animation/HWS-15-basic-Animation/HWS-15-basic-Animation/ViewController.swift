//
//  ViewController.swift
//  HWS-15-basic-Animation
//
//  Created by Massimo Savino on 2022-07-23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private struct Constants {
        static let penguin = "penguin"
        static let cellIdentifier = "cellIdentifier"
    }
    @IBOutlet weak var animationButton: UIButton!
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
    }
    
    func configureImage() {
        imageView = UIImageView(image: UIImage(named: Constants.penguin))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    
    @IBAction func animationButtonTapped(_ sender: UIButton) {
        sender.isHidden = true
        
        chooseAnimation(animationNumber: currentAnimation, sender: sender)
        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
    }
    
    func chooseAnimation(animationNumber: Int, sender: UIButton) {
        let oneSecond = CGFloat(1)
        let noDelay = CGFloat(0)
        UIView.animate(
            withDuration: oneSecond,
            delay: noDelay,
            
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 5,
            
            options: [],
            animations: {
                switch animationNumber {
                case 0:
                    self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                case 1:
                    self.imageView.transform = .identity
                case 2:
                    self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                case 3:
                    self.imageView.transform = .identity
                case 4:
                    self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                case 5:
                    self.imageView.transform = .identity
                case 6:
                    self.imageView.alpha = 0.1
                    self.imageView.backgroundColor = UIColor.green
                case 7:
                    self.imageView.alpha = 1
                    self.imageView.backgroundColor = UIColor.clear
                    
                default:
                    break
                }
            },
            completion: { finished in
                sender.isHidden = false
            })
    }
}
