//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var statusBarOrientation: UIInterfaceOrientation? {
        get {
            guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                #if DEBUG
                fatalError("Could not obtain UIInterfaceOrientation from a valid windowScene")
                #else
                return nil
                #endif
            }
            return orientation
        }
    }
    
    // MARK: - Private properties
    private let photoLayoutProvider = PhotoLayoutProvider()
    
    @IBOutlet weak var mainSquare: UIView!
    
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    @IBOutlet weak var stackViewGestureIndication: UIStackView!
    
    @IBOutlet var bottomButtons: [UIButton]!
    
    // Tags to identify the elements
    private var tagPlusImageViews = 0
    private var tagBottomButton = 0
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
    private var whiteViews: [UIView] = []
    
    private var imageViews: [UIImageView] = []
    
    private var imagesFromImageViews: [UIImage] = []
    
    private var plusImageViews: [UIImageView] = []
    
    private let screenHeight = UIScreen.main.bounds.height
    
    private var mySwipeGestureRecognizer: UISwipeGestureRecognizer! = nil
    
    private let gridScreenshot: UIImage! = nil
    
    
    
    @IBAction private func changeGridToDefaultConfig(_ sender: UIButton) {
        
        cleanGridLayoutView()
        
        
        setupBottomButtons(button: bottomButtons[sender.tag])
        
        let layout = photoLayoutProvider.photoLayouts[0]
        setupGridLayoutView(layout: layout)
        
    }
    
    @IBAction private func changeGridToReverseConfig(_ sender: UIButton) {
        
        cleanGridLayoutView()
        
        
        setupBottomButtons(button: bottomButtons[sender.tag])
        
        let layout = photoLayoutProvider.photoLayouts[1]
        setupGridLayoutView(layout: layout)
    }
    
    
    @IBAction private func changeGridToCrossConfig(_ sender: UIButton) {
        
        cleanGridLayoutView()
        
        
        setupBottomButtons(button: bottomButtons[sender.tag])
        
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
        
        imagesFromImageViews.removeAll()
        
        resetButtonImages()
        
        tagImageView = 0
        
        stackViewGestureIndication.isHidden = true
        
        
        view.removeGestureRecognizer(mySwipeGestureRecognizer)
        
    }
    
    private func setupBottomButtons(button: UIButton) {
        button.setImage(UIImage(named: "Selected"), for: .normal)
    }
    
    private func addATag() {
        for button in bottomButtons {
            button.tag = tagBottomButton
            tagBottomButton += 1
        }
    }
    
    private func resetButtonImages() {
        for button in bottomButtons {
            button.setImage(nil, for: .normal)
        }
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
        
        imageView.contentMode = .redraw
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
            self.imagesFromImageViews.append(image)
            self.stackViewGestureIndication.isHidden = false
            self.view.addGestureRecognizer(self.mySwipeGestureRecognizer)
            
            for plusImageView in self.plusImageViews where plusImageView.tag == clickedView.tag {
                plusImageView.image = nil
            }
        }
    }
    
    @objc private func launchTheSwipeGestureAnimation(_ sender: UISwipeGestureRecognizer) {
        
        let dataForSwipeAnimations = (-self.screenHeight / 2.0) - (self.mainSquare.frame.height / 2) - 10
        
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            
            self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: 0, dy: dataForSwipeAnimations)
        }
        
        animator.startAnimation()
        shareContentOfTheGrid(dataForSwipeAnimations: dataForSwipeAnimations)
    }
    
    private func shareContentOfTheGrid(dataForSwipeAnimations: CGFloat) {
        switch mySwipeGestureRecognizer.state {
        case .ended:
            
            let items = [screenShotMethod()]
            
            let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            
            present(ac, animated: true)
            
            ac.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                
                let animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
                    self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: 0, dy: abs(dataForSwipeAnimations))
                }
                
                if activityType == nil || completed {
                    animator.startAnimation()
                }
            }
            
        default:
            break
        }
    }
    
    
    private func hide(_ element: UIView) {
        element.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape mode")
            mySwipeGestureRecognizer.direction = .left
            
        }
        
        if UIDevice.current.orientation.isPortrait {
            print("Portrait mode")
            mySwipeGestureRecognizer.direction = .up
        }
    }
    
    private func screenShotMethod() -> UIImage? {
        //Create the UIImage
        UIGraphicsBeginImageContext(mainSquare.frame.size)
        mainSquare.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // MARK: - Internal methods
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(launchTheSwipeGestureAnimation(_:)))
        
        hide(stackViewGestureIndication)
        resetButtonImages()
        swipeGesture.direction = statusBarOrientation!.isPortrait ? .up : .left
        
        mySwipeGestureRecognizer = swipeGesture
        
        addATag()
    }
    
}

