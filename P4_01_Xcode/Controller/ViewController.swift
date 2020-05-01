//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWindowSceneDelegate {
    
    // MARK: - Private properties
    private let photoLayoutProvider = PhotoLayoutProvider()
    private let screenHeight = UIScreen.main.bounds.height
    private let size = UIScreen.main.bounds.size
    private let screenWidth = UIScreen.main.bounds.width
    private let gridScreenshot: UIImage! = nil
    
    private var deviceIsPortraitMode = false
    private var deviceIsLandscapeMode = false
    
    private var mySwipeGestureRecognizer: UISwipeGestureRecognizer! = nil
    
    var ac : UIActivityViewController! = nil
    /// Tags to identify the elements
    private var tagPlusImageViews = 0
    private var tagBottomButton = 0
    
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
    // MARK: Private outlet
    @IBOutlet weak var mainSquare: UIView!
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    @IBOutlet private weak var stackViewGestureIndication: UIStackView!
    
    /// Outlet Collection
    @IBOutlet private var bottomButtons: [UIButton]!
    
    // mainSquare's children
    private var whiteViews: [UIView] = []
    private var imageViews: [UIImageView] = []
    private var imagesFromImageViews: [UIImage] = []
    private var plusImageViews: [UIImageView] = []
    
    // MARK: Private action
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
    
    // MARK: - Private methods
    
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
        
        /// To add the swipe gesture recognizer
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
    
    @objc private func launchTheSwipeGestureAnimation(_ sender: UISwipeGestureRecognizer) {
        launchTheAnimation()
        shareContentOfTheGrid()
    }
    
    func sharedShareAction(controller: UIViewController) {

        controller.present(ac,animated: true, completion: nil)

        ac.completionWithItemsHandler = { activity, completed, items, error in
                if completed || !completed {
                    self.ac.dismiss(animated: true) {
                        self.launchTheReverseAnimation()
                    }
                    return
                }
            
            }
    }
    
    private func shareContentOfTheGrid() {
        
        switch mySwipeGestureRecognizer.state {
            
        case .ended:
            let items = [screenShotMethod()]
            
            ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            sharedShareAction(controller: self)
        default:
            break
        }
    }
    
    private func hide(_ element: UIView) {
        element.isHidden = true
    }
    
    private func screenShotMethod() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: mainSquare.bounds.size)
        let image = renderer.image { ctx in
            mainSquare.drawHierarchy(in: mainSquare.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    // MARK: (objc) private methods
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
    
    // MARK: - Internal methods
    fileprivate func initializeSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(launchTheSwipeGestureAnimation(_:)))
        mySwipeGestureRecognizer = swipeGesture
        
        if size.width < size.height {
            mySwipeGestureRecognizer.direction = .up
            deviceIsPortraitMode = true
        } else {
            mySwipeGestureRecognizer.direction = .left
            deviceIsLandscapeMode = true
        }
    }
    
    func launchTheAnimation() {
        deviceIsPortraitMode ? animations[0].startAnimation() : animations[1].startAnimation()
    }
    
    func launchTheReverseAnimation() {
        deviceIsPortraitMode ? animations[2].startAnimation() : animations[3].startAnimation()
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSwipeGesture()
        hide(stackViewGestureIndication)
        resetButtonImages()
        addATag()
    }
    
    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        mySwipeGestureRecognizer.direction = UIDevice.current.orientation.isPortrait ? .up : .left
        deviceIsPortraitMode = UIDevice.current.orientation.isPortrait ? true : false
        
        if ac != nil {
            ac.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
