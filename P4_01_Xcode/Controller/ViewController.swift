//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
    }
    @IBAction func changeGridToConfig2(_ sender: Any) {
    }
    @IBAction func changeGridToConfig3(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            // Resizing and cropping the photo if true
            picker.allowsEditing = true
            picker.sourceType = .camera
            present(picker, animated: true, completion: nil)

        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)

        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true, completion: nil)
            
        }
        
    }
    
}
