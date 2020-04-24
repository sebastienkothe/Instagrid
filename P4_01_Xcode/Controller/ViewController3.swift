//
//  ViewController3.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 24/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet weak var imageView10: UIImageView!
    
    @IBOutlet weak var plus7: UIImageView!
    @IBOutlet weak var plus8: UIImageView!
    @IBOutlet weak var plus9: UIImageView!
    @IBOutlet weak var plus10: UIImageView!
    
    override func viewDidLoad() {
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
    
    @objc func addPhotoToImageView7() {
        imageView7.isUserInteractionEnabled = true
        imageView7.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView7.image = image
            self.plus7.isHidden = true
        }
    }
    
    @objc func addPhotoToImageView8() {
        imageView8.isUserInteractionEnabled = true
        imageView8.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView8.image = image
            self.plus8.isHidden = true
        }
    }
    
    @objc func addPhotoToImageView9() {
        imageView9.isUserInteractionEnabled = true
        imageView9.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView9.image = image
            self.plus9.isHidden = true
        }
    }
    
    @objc func addPhotoToImageView10() {
        imageView10.isUserInteractionEnabled = true
        imageView10.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView10.image = image
            self.plus10.isHidden = true
        }
    }
}
