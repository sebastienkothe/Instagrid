//
//  ViewController3.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 24/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    // MARK: - Private properties
    @IBOutlet private weak var imageView7: UIImageView!
    @IBOutlet private weak var imageView8: UIImageView!
    @IBOutlet private weak var imageView9: UIImageView!
    @IBOutlet private weak var imageView10: UIImageView!
    
    @IBOutlet private weak var plus7: UIImageView!
    @IBOutlet private weak var plus8: UIImageView!
    @IBOutlet private weak var plus9: UIImageView!
    @IBOutlet private weak var plus10: UIImageView!
    
    // MARK: - Private methods
    @objc private func addPhotoToImageView7() {
        imageView7.isUserInteractionEnabled = true
        imageView7.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView7.image = image
            self.plus7.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView8() {
        imageView8.isUserInteractionEnabled = true
        imageView8.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView8.image = image
            self.plus8.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView9() {
        imageView9.isUserInteractionEnabled = true
        imageView9.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView9.image = image
            self.plus9.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView10() {
        imageView10.isUserInteractionEnabled = true
        imageView10.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView10.image = image
            self.plus10.isHidden = true
        }
    }
    
    // MARK: - Internal methods
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureImageView7 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView7))
        imageView7.addGestureRecognizer(gestureImageView7)
        
        let gestureImageView8 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView8))
        imageView8.addGestureRecognizer(gestureImageView8)
        
        let gestureImageView9 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView9))
        imageView9.addGestureRecognizer(gestureImageView9)
        
        let gestureImageView10 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView10))
        imageView10.addGestureRecognizer(gestureImageView10)
    }
    
}
