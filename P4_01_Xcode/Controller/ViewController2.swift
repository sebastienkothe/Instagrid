//
//  ViewController2.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 24/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    // MARK: - Private properties
    @IBOutlet private weak var imageView4: UIImageView!
    @IBOutlet private weak var imageView5: UIImageView!
    @IBOutlet private weak var imageView6: UIImageView!
    
    @IBOutlet private weak var plus4: UIImageView!
    @IBOutlet private weak var plus5: UIImageView!
    @IBOutlet private weak var plus6: UIImageView!
    
    // MARK: - Private methods
    @objc private func addPhotoToImageView4() {
        imageView4.isUserInteractionEnabled = true
        imageView4.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView4.image = image
            self.plus4.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView5() {
        imageView5.isUserInteractionEnabled = true
        imageView5.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView5.image = image
            self.plus5.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView6() {
        imageView6.isUserInteractionEnabled = true
        imageView6.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView6.image = image
            self.plus6.isHidden = true
        }
    }
    
    // MARK: - Internal methods
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureImageView4 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView4))
        imageView4.addGestureRecognizer(gestureImageView4)
        
        let gestureImageView5 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView5))
        imageView5.addGestureRecognizer(gestureImageView5)
        
        let gestureImageView6 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView6))
        imageView6.addGestureRecognizer(gestureImageView6)
        
    }
    
    
}
