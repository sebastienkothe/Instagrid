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
    
    // UIImagePickerController object
    var imagePicker = UIImagePickerController()
    
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
    }
    @IBAction func changeGridToConfig2(_ sender: Any) {
    }
    @IBAction func changeGridToConfig3(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pictureEdited = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image1.image = pictureEdited
        }
    }
}
