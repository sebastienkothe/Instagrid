//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

/* ViewController class must conform to the protocols : UIImagePickerControllerDelegate and UINavigationControllerDelegate to handle the camera and photo library */

class ViewController: UIViewController {
    
    
    // Width of the screen
    let screenWidth = UIScreen.main.bounds.width
    
    // Instagrid Label
    @IBOutlet weak var instagridLabel: UILabel!
    
    // Blue main square
    @IBOutlet weak var mainSquare: UIView!
    
    // Blocks
    @IBOutlet weak var block1: UIView!
    
    // Images
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    // Plus image
    @IBOutlet weak var plus1: UIImageView!
    @IBOutlet weak var plus2: UIImageView!
    @IBOutlet weak var plus3: UIImageView!
    
    // Buttons
    @IBAction func changeGridToConfig1(_ sender: Any) {
        
    }
    
    @IBAction func changeGridToConfig2(_ sender: Any) {

    }
    
    @IBAction func changeGridToConfig3(_ sender: Any) {

    }
    
    @objc func addPhotoToImageView1() {
        imageView1.isUserInteractionEnabled = true
        imageView1.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView1.image = image
            self.plus1.isHidden = true
        }
    }
    
    @objc func addPhotoToImageView2() {
        imageView2.isUserInteractionEnabled = true
        imageView2.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView2.image = image
            self.plus2.isHidden = true
        }
    }
    
    @objc func addPhotoToImageView3() {
        imageView3.isUserInteractionEnabled = true
        imageView3.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.imageView3.image = image
            self.plus3.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // To handle the gesture on
          let tapGestureImageView1 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView1))
          imageView1.addGestureRecognizer(tapGestureImageView1)
          
          let tapGestureImageView2 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView2))
          imageView2.addGestureRecognizer(tapGestureImageView2)
          
          let tapGestureImageView3 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView3))
          imageView3.addGestureRecognizer(tapGestureImageView3)
      
    }
    
}
