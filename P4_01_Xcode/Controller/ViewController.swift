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
    
    // Represents to width of the screen
    let screenWidth = UIScreen.main.bounds.width
    
    // Instagrid Label
    @IBOutlet weak var instagridLabel: UILabel!
    
    // Main square
    @IBOutlet weak var mainSquare: UIView!
    
    // Blocks
    @IBOutlet weak var block1: UIView!
    
    // Images
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    // Plus image
    @IBOutlet weak var plus1: UIImageView!
    @IBOutlet weak var plus2: UIImageView!
    @IBOutlet weak var plus3: UIImageView!
    
    // Buttons
    @IBAction func changeGridToConfig1(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.image1.image = image
            self.plus1.isHidden = true
        }
    }
    
    @IBAction func changeGridToConfig2(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.image2.image = image
            self.plus2.isHidden = true
        }
    }
    
    @IBAction func changeGridToConfig3(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.image3.image = image
            self.plus3.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
