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
    private let photoLayoutProvider = PhotoLayoutProvider()
    
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    
    @IBOutlet weak var buttonForChangeGridToReverseConfig: UIButton!
    @IBOutlet weak var buttonForChangeGridToDefaultConfig: UIButton!
    @IBOutlet weak var buttonForChangeGridToCrossConfig: UIButton!
    
    
    private var whiteViews: [UIView] = []
    private var imageViews: [UIImageView] = []
    private var plusImageViews: [UIImageView] = []
    
    // MARK: - Private methods
    private func setupGridLayoutView(layout: PhotoLayout) {
        
        addWhiteViewsTo(stackView: topStackView, numberOfViews: layout.numberOfTopView)
        addWhiteViewsTo(stackView: botStackView, numberOfViews: layout.numberOfBotView)
        
    }
    
    private func cleanGridLayoutView() {
        
        for view in topStackView.arrangedSubviews {
            topStackView.removeArrangedSubview(view)
        }
        
        for view in botStackView.arrangedSubviews {
            botStackView.removeArrangedSubview(view)
        }
        
        for plusImageViews in plusImageViews {
            plusImageViews.removeFromSuperview()
        }
        
        for imageView in imageViews {
            imageView.removeFromSuperview()
        }
        
    }
    
    private func addWhiteViewsTo(stackView: UIStackView, numberOfViews: Int) {
        
        for _ in 1...numberOfViews {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            stackView.addArrangedSubview(whiteView)
            
            // Add my white views in [whiteViews]
            whiteViews.append(whiteView)
            
            addImageViewTo(whiteView: whiteView)
            
        }
        
    }
    
    fileprivate func setupImageView(_ imageView: UIImageView, _ whiteView: UIView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //constraints here
            imageView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor), imageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor), imageView.heightAnchor.constraint(equalTo: whiteView.heightAnchor)
        ])
    }
    
    private func addImageViewTo(whiteView: UIView) {
        let imageView = UIImageView()
        whiteView.addSubview(imageView)
        
        imageViews.append(imageView)
        imageView.contentMode = .scaleAspectFill
        
        imageView.backgroundColor = .cyan
        
        addPlusImageTo(imageView)
        setupImageView(imageView, whiteView)
    }
    
    
    
    private func addPlusImageTo(_ view: UIView) {
        
        let plusImageView = UIImageView()
        view.addSubview(plusImageView)
        plusImageView.image = UIImage(named: "Plus")
        
        plusImageViews.append(plusImageView)
        setupPlusImageViews(plusImageView, view)
        
    }
    
    fileprivate func setupPlusImageViews(_ plusImageView: UIImageView, _ view: UIView) {
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //constraints here
            plusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor), plusImageView.widthAnchor.constraint(equalToConstant: 40), plusImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func hide(_ element: UIView) {
        element.isHidden = true
    }
    
    @IBAction private func changeGridToReverseConfig(_ sender: Any) {
        cleanGridLayoutView()
        
        let layout = photoLayoutProvider.photoLayouts[0]
        setupGridLayoutView(layout: layout)
    }
    
    @IBAction private func cchangeGridToDefaultConfig(_ sender: Any) {
        
        cleanGridLayoutView()
        
        let layout = photoLayoutProvider.photoLayouts[1]
        setupGridLayoutView(layout: layout)
        
    }
    
    @IBAction private func changeGridToCrossConfig(_ sender: Any) {
        
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
