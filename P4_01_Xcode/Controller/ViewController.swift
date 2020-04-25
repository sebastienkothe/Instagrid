//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - File private methods
    fileprivate func setupGridLayoutView(layout: PhotoLayout) {
        
        addButtonViewsTo(stackView: topStackView, numberOfViews: layout.numberOfTopView)
        addButtonViewsTo(stackView: botStackView, numberOfViews: layout.numberOfBotView)
        
    }
    
    fileprivate func cleanGridLayoutView() {
        for view in topStackView.arrangedSubviews {
            topStackView.removeArrangedSubview(view)
        }
        
        for view in botStackView.arrangedSubviews {
            botStackView.removeArrangedSubview(view)
        }
    }
    
    // MARK: - Private properties
    private let photoLayoutProvider = PhotoLayoutProvider()
    
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    
    // MARK: - Private methods
    private func addButtonViewsTo(stackView: UIStackView, numberOfViews: Int) {
        for _ in 1...numberOfViews {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            stackView.addArrangedSubview(whiteView)
        }
    }
        
    @IBAction private func changeGridToConfig1(_ sender: Any) {
        
        cleanGridLayoutView()
        
        let layout = photoLayoutProvider.photoLayouts[0]
        setupGridLayoutView(layout: layout)
        
    }
    
    @IBAction private func changeGridToConfig2(_ sender: Any) {
        cleanGridLayoutView()
        
        let layout = photoLayoutProvider.photoLayouts[1]
        setupGridLayoutView(layout: layout)
    }
    
    @IBAction private func changeGridToConfig3(_ sender: Any) {
        cleanGridLayoutView()
        
        let layout = photoLayoutProvider.photoLayouts[2]
        setupGridLayoutView(layout: layout)
    }
    
    @objc private func addPhotoToImageView1(imageView: UIImageView) {
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            imageView.image = image
            //self.plus1.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView2() {
        //        imageView2.isUserInteractionEnabled = true
        //        imageView2.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            //            self.imageView2.image = image
            //            self.plus2.isHidden = true
        }
    }
    
    @objc private func addPhotoToImageView3() {
        //        imageView3.isUserInteractionEnabled = true
        //        imageView3.contentMode = .scaleAspectFill
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            //            self.imageView3.image = image
            //            self.plus3.isHidden = true
        }
    }
    
    
    
    //    // MARK: - Internal methods
    //    override internal func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        let gestureImageView1 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView1))
    //        imageView1.addGestureRecognizer(gestureImageView1)
    //
    //        let gestureImageView2 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView2))
    //        imageView2.addGestureRecognizer(gestureImageView2)
    //
    //        let gestureImageView3 = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView3))
    //        imageView3.addGestureRecognizer(gestureImageView3)
    //
    //        /* let swipeGestureVC1 = UISwipeGestureRecognizer(target: self, action: #selector())
    //        view.addGestureRecognizer(swipeGestureVC1) */
    //
    //    }
    
}
