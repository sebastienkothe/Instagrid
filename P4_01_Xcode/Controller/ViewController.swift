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
    
    @IBOutlet weak var mainSquare: UIView!
    
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    
    @IBOutlet private weak var buttonForChangeGridToReverseConfig: UIButton!
    @IBOutlet private weak var buttonForChangeGridToDefaultConfig: UIButton!
    @IBOutlet private weak var buttonForChangeGridToCrossConfig: UIButton!
    
    private var whiteViews: [UIView] = []
    
    private var imageViews: [UIImageView] = [] {
        didSet {
            addTapGestureRecognizerToImageViews()
        }
    }
    
    private var plusImageViews: [UIImageView] = []
    
    // MARK: - Private methods
    
    @IBAction private func changeGridToDefaultConfig(_ sender: Any) {
        
        cleanGridLayoutView()
        
        buttonForChangeGridToDefaultConfig.setImage(UIImage(named: "Selected"), for: .normal)
        let layout = photoLayoutProvider.photoLayouts[0]
        setupGridLayoutView(layout: layout)
        
    }
    
    @IBAction private func changeGridToReverseConfig(_ sender: Any) {
        
        cleanGridLayoutView()
        
        buttonForChangeGridToReverseConfig.setImage(UIImage(named: "Selected"), for: .normal)
        let layout = photoLayoutProvider.photoLayouts[1]
        setupGridLayoutView(layout: layout)
    }
    
    
    @IBAction private func changeGridToCrossConfig(_ sender: Any) {
        
        cleanGridLayoutView()
        
        buttonForChangeGridToCrossConfig.setImage(UIImage(named: "Selected"), for: .normal)
        let layout = photoLayoutProvider.photoLayouts[2]
        setupGridLayoutView(layout: layout)
    }
    
    /// Method to delete the views when the user tap on buttons
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
            imageView.gestureRecognizers?.removeAll()
        }
        
        imageViews.removeAll()
        
        buttonForChangeGridToDefaultConfig.currentImage
//        buttonForChangeGridToCrossConfig
//        buttonForChangeGridToReverseConfig
    }
    
    private func setupGridLayoutView(layout: PhotoLayout) {
        
        addWhiteViewsTo(stackView: topStackView, numberOfViews: layout.numberOfTopView)
        addWhiteViewsTo(stackView: botStackView, numberOfViews: layout.numberOfBotView)
        
    }
    
    private func addWhiteViewsTo(stackView: UIStackView, numberOfViews: Int) {
        
        for _ in 1...numberOfViews {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            stackView.addArrangedSubview(whiteView)
            // Add my white views in [whiteViews]
            whiteViews.append(whiteView)
            
            addImageViewTo(whiteView)
        }
        
        
    }
    
    private func addImageViewTo(_ whiteView: UIView) {
        let imageView = UIImageView()
        // Can deleted this after setup
        imageView.backgroundColor = .cyan
        whiteView.addSubview(imageView)
        imageViews.append(imageView)
        
        setupImageView(imageView, whiteView)
        addPlusImageTo(imageView)
        
        
    }
    
    private func setupImageView(_ imageView: UIImageView, _ whiteView: UIView) {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //constraints here
            imageView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor), imageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor), imageView.heightAnchor.constraint(equalTo: whiteView.heightAnchor)
        ])
        
    }
    
    private func addPlusImageTo(_ view: UIView) {
        
        let plusImageView = UIImageView()
        view.addSubview(plusImageView)
        plusImageView.image = UIImage(named: "Plus")
        plusImageViews.append(plusImageView)
        
        setupPlusImageViews(plusImageView, view)
        
    }
    
    private func setupPlusImageViews(_ plusImageView: UIImageView, _ view: UIView) {
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //constraints here
            plusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor), plusImageView.widthAnchor.constraint(equalToConstant: 40), plusImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    
    }
    
    private func addTapGestureRecognizerToImageViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView(sender:)))
        
        for (index, view) in imageViews.enumerated() {
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tap)
            view.tag = index
        }
    }
    
    @objc private func addPhotoToImageView(sender: UITapGestureRecognizer) {
        
        let clickedView = imageViews[sender.view!.tag]
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            clickedView.image = image
        }
    }
    
    private func hide(_ element: UIView) {
        element.isHidden = true
    }
    
    // MARK: - Internal methods
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
