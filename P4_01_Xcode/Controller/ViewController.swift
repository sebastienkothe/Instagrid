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
    
    // This tag associate to image Views for recognize them
    private var tagPlusImageViews = 0
    
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
    private var whiteViews: [UIView] = []
    
    private var imageViews: [UIImageView] = []
    
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
        
        buttonForChangeGridToDefaultConfig.setImage(nil, for: .normal)
        buttonForChangeGridToCrossConfig.setImage(nil, for: .normal)
        buttonForChangeGridToReverseConfig.setImage(nil, for: .normal)
        
        tagImageView = 0
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
        
        whiteView.addSubview(imageView)
        imageViews.append(imageView)
        
        setupImageView(imageView, whiteView)
        addTapGestureRecognizerToImageViews(imageView: imageView)
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
        
        plusImageView.tag = tagPlusImageViews
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
    
    private func addTapGestureRecognizerToImageViews(imageView: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView(sender:)))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        imageView.tag = tagImageView
        
        tagImageView += 1
    }
    
    @objc private func addPhotoToImageView(sender: UITapGestureRecognizer) {
        
        let clickedView = imageViews[sender.view!.tag]
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            clickedView.image = image
            
            for plusImageView in self.plusImageViews where plusImageView.tag == clickedView.tag {
                plusImageView.image = nil
            }
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
