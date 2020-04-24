//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    private let screenWidth = UIScreen.main.bounds.width
    
    @IBOutlet private weak var instagridLabel: UILabel!
    @IBOutlet private weak var mainSquare: UIView!
    @IBOutlet private weak var imageView1: UIImageView!
    @IBOutlet private weak var imageView2: UIImageView!
    @IBOutlet private weak var imageView3: UIImageView!
    @IBOutlet private weak var plus1: UIImageView!
    @IBOutlet private weak var plus2: UIImageView!
    @IBOutlet private weak var plus3: UIImageView!
    
    // MARK: - Private methods
    @IBAction private func changeGridToConfig1(_ sender: Any) {
        
    }
    
    @IBAction private func changeGridToConfig2(_ sender: Any) {
        
    }
    
    @IBAction private func changeGridToConfig3(_ sender: Any) {
        
    }
    
    @objc private func addPhotoToImageView1() {
        imageView1.isUserInteractionEnabled = true
        imageView1.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView1.image = image
            self.plus1.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView2() {
        imageView2.isUserInteractionEnabled = true
        imageView2.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView2.image = image
            self.plus2.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView3() {
        imageView3.isUserInteractionEnabled = true
        imageView3.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView3.image = image
            self.plus3.isHidden = true
        }
    }
    
    // MARK: - Internal methods
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureImageView1 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView1))
        imageView1.addGestureRecognizer(gestureImageView1)
        
        let gestureImageView2 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView2))
        imageView2.addGestureRecognizer(gestureImageView2)
        
        let gestureImageView3 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView3))
        imageView3.addGestureRecognizer(gestureImageView3)
    }
    
}
