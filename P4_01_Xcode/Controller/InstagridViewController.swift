//
//  InstagridViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class InstagridViewController: UIViewController {
    
    // MARK: - Internal properties
    
    /// Not private because used in PropertyAnimators.swift
    @IBOutlet weak var gridPhotoLayoutContainerView: UIView!
    
    // MARK: - Private properties
    private let photoLayoutProvider = PhotoLayoutProvider()
    
    // Device screen informations
    private let screenSize = UIScreen.main.bounds.size
    
    /// The swipe gesture recognizer
    private var swipeToShareRecognizer: UISwipeGestureRecognizer?
    
    /// The screenshot from the grid
    private var gridPhotoLayoutContainerViewScreenshot: UIImage?
    
    /// ActivityViewController. Used to share the grid
    private var instagridActivityViewController: UIActivityViewController?
 
    // Tags to identify the elements
    private var tagPlusImageViews = 0
    
    /// Determinate the interface orientation
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    // MARK: Private outlet
    @IBOutlet private weak var gridTopStackView: UIStackView!
    @IBOutlet private weak var gridBotStackView: UIStackView!
    @IBOutlet private weak var stackViewGestureIndication: UIStackView!
    @IBOutlet private weak var cleanGridButton: UIButton!
    
    /// Bottom buttons' Outlet Collection
    @IBOutlet private var photoLayoutButtons: [UIButton]!
    
    // gridPhotoLayoutContainerView's children
    private var whiteViews: [UIView] = []
    private var numberOfWhiteViews = 0
    private var imageViews: [UIImageView] = []
    private var plusImageViews: [UIImageView] = []
    
    /// Used to save grid images
    private var userPhotosDictionary: [Int: UIImage] = [:]
    
    private var imagesFromImageViews: [UIImage] = [] {
        didSet {
            cleanGridButton.isHidden = imagesFromImageViews.count > 0 ? false : true
        }
    }
    
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
    /// Property used to change the direction of the swipe gesture recognizer
    private var deviceIsPortraitMode = false {
        didSet {
            swipeToShareRecognizer?.direction = deviceIsPortraitMode ? .up : .left
        }
    }

    // MARK: Private action
    @IBAction private func didTapOnLayoutButton(_ sender: UIButton) {
        
        cleanGridLayoutView()
        
        handlePhotoLayoutButtonSelection(selectedTag: sender.tag)
        
        let layout = photoLayoutProvider.photoLayouts[sender.tag]
        
        setupGridLayoutView(layout: layout)
    }
    
    @IBAction private func cleanImagesFromTheGridButton() {
        
        for imageView in imageViews {
            imageView.image = nil
            addPlusImageTo(imageView)
        }
        
        imagesFromImageViews.removeAll()
        plusImageViews.removeAll()
        userPhotosDictionary.removeAll()
        
        handleSwipeGestureRecognizer()
    }
    
    // MARK: - Private methods
    
    /// Method to clean grid layout view
    private func cleanGridLayoutView() {
        
        for view in gridTopStackView.arrangedSubviews {
            gridTopStackView.removeArrangedSubview(view)
        }
        
        for view in gridBotStackView.arrangedSubviews {
            gridBotStackView.removeArrangedSubview(view)
        }
        
        for whiteView in whiteViews {
            whiteView.removeFromSuperview()
        }
        
        for imageView in imageViews {
            imageView.removeFromSuperview()
            imageView.gestureRecognizers?.removeAll()
        }
        
        for plusImageViews in plusImageViews {
            plusImageViews.removeFromSuperview()
        }
        
        // Reset tables
        whiteViews.removeAll()
        imageViews.removeAll()
        plusImageViews.removeAll()
        
        /// Reset tag
        tagImageView = 0
    }
    
    /// Method for adding user images to the new grid from the userPhotosDictionary
    private func addUserImagesToNewLayout() {
        
        for (tag, image) in userPhotosDictionary {
            if tag + 1 > whiteViews.count {
                continue
            }
            
            imageViews[tag].image = image
            imageViews[tag].subviews[0].removeFromSuperview()
        }
        
    }
    
    /// Method for configuring buttons
    private func setupLayoutButtons() {
        for (index, button) in photoLayoutButtons.enumerated() {
            button.tag = index
            setupLayoutButtonImage(button: button)
        }
    }
    
    /// Method to manage if the button is selected or not
    private func handlePhotoLayoutButtonSelection(selectedTag: Int) {
        for button in photoLayoutButtons {
            button.isSelected = button.tag == selectedTag
        }
    }
    
    /// Method to define button images
    private func setupLayoutButtonImage(button: UIButton) {
        button.setImage(nil, for: .normal)
        button.setImage(UIImage(named: "Selected"), for: .selected)
    }
    
    /// Method to define button images
    private func setupGridLayoutView(layout: PhotoLayout) {
        
        addWhiteViewsTo(stackView: gridTopStackView, numberOfViews: layout.numberOfTopView)
        addWhiteViewsTo(stackView: gridBotStackView, numberOfViews: layout.numberOfBotView)
        addUserImagesToNewLayout()
        numberOfWhiteViews = whiteViews.count
        handleSwipeGestureRecognizer()
    }
    
    /// Method to to prevent the user from sharing an empty grid
    private func handleSwipeGestureRecognizer() {
        
        guard !(numberOfWhiteViews == 3 && userPhotosDictionary.count == 1 &&  userPhotosDictionary.index(forKey: 3) != nil) else {
            handleStateSwipeGesture(state: "Off")
            return
        }
        
        guard !(numberOfWhiteViews == 4 && userPhotosDictionary.count == 1 &&  userPhotosDictionary.index(forKey: 3) != nil) else {
            handleStateSwipeGesture(state: "On")
            return
        }
        
        guard userPhotosDictionary.count >= 1 else {
            handleStateSwipeGesture(state: "Off")
            return
        }
        
        guard userPhotosDictionary.count < 1 else {
            handleStateSwipeGesture(state: "On")
            return
        }
        
    }
    
    /// Method to handle the state of the swipe gesture
    private func handleStateSwipeGesture(state: String) {
        guard let swipeToShareRecognizer = swipeToShareRecognizer else { return }
        
        if state == "On" {
            stackViewGestureIndication.isHidden = false
            swipeToShareRecognizer.isEnabled = true
        } else {
            stackViewGestureIndication.isHidden = true
            swipeToShareRecognizer.isEnabled = false
        }
    }
    
    /// Method to add the white views
    private func addWhiteViewsTo(stackView: UIStackView, numberOfViews: Int) {
        
        for _ in 1...numberOfViews {
            let whiteView = UIView()
            whiteView.backgroundColor = .white
            stackView.addArrangedSubview(whiteView)
            
            // Add white views in [whiteViews]
            whiteViews.append(whiteView)
            
            addImageViewTo(whiteView)
        }
    }
    
    /// Method to add the an UIImageView in a whiteView
    private func addImageViewTo(_ whiteView: UIView) {
        let imageView = UIImageView()
        
        whiteView.addSubview(imageView)
        imageViews.append(imageView)
        
        setupImageView(imageView, whiteView)
        addTapGestureRecognizerToImageViews(imageView: imageView)
        addPlusImageTo(imageView)
    }
    
    /// Method to add constraints to imageView
    private func setupImageView(_ imageView: UIImageView, _ whiteView: UIView) {
        
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalTo: whiteView.widthAnchor), imageView.heightAnchor.constraint(equalTo: whiteView.heightAnchor)
        ])
        
    }
    
    /// Method to add plusImage to imageView
    private func addPlusImageTo(_ view: UIView) {
        
        let plusImageView = UIImageView()
        view.addSubview(plusImageView)
        plusImageView.image = UIImage(named: "Plus")
        
        plusImageView.tag = tagPlusImageViews
        plusImageViews.append(plusImageView)
        
        setupPlusImageViews(plusImageView, view)
        
    }
    
    /// Method to add constraints to plusImageView
    private func setupPlusImageViews(_ plusImageView: UIImageView, _ view: UIView) {
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            plusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor), plusImageView.widthAnchor.constraint(equalToConstant: 40), plusImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    /// Method to add tap gesture recognizer  to imageView
    private func addTapGestureRecognizerToImageViews(imageView: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView(sender:)))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.tag = tagImageView
        
        tagImageView += 1
    }
    
    /// Method to handle the UIActivityViewController
    private func handleTheActivityViewController() {
        guard let ac = instagridActivityViewController else { return }
        // To present it
        present(ac, animated: true, completion: nil)
        
        // To handle the completion
        ac.completionWithItemsHandler = { _, _, _, _ in
            self.instagridActivityViewController?.dismiss(animated: true) {
                self.startTheEndOfSharingAnimation()
            }
            return
        }
    }
    
    /// Method to share the screenshot
    private func shareContentOfTheGrid() {
        guard let swipeToShareRecognizer = swipeToShareRecognizer else { return }
        
        switch swipeToShareRecognizer.state {
        case .ended:
            let items = [screenShotMethod()]
            
            instagridActivityViewController = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            
            handleTheActivityViewController()
        default:
            break
        }
    }
    
    /// Method to share an UIView
    private func hide(_ element: UIView) {
        element.isHidden = true
    }
    
    /// Method to take a screenshot of mainsquare view
    private func screenShotMethod() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: gridPhotoLayoutContainerView.bounds.size)
        let image = renderer.image { ctx in
            gridPhotoLayoutContainerView.drawHierarchy(in: gridPhotoLayoutContainerView.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    /// Method to initialize the swipe gesture recognizer
    private func initializeSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ManageActionsAfterSwipeGestureDetection(_:)))
        swipeToShareRecognizer = swipeGesture
        gridPhotoLayoutContainerView.addGestureRecognizer(swipeGesture)
        
        deviceIsPortraitMode = screenSize.width < screenSize.height ? true : false
        
    }
    
    /// Method to start the animation according to the orientation of the iPhone
    private func startSharingAnimation() {
        deviceIsPortraitMode ? UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            
            self.gridPhotoLayoutContainerView.frame = self.gridPhotoLayoutContainerView.frame.offsetBy(dx: 0, dy: -UIScreen.main.bounds.maxY)
        }.startAnimation() : UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            
            self.gridPhotoLayoutContainerView.frame = self.gridPhotoLayoutContainerView.frame.offsetBy(dx: -UIScreen.main.bounds.maxX, dy: 0)
        }.startAnimation()
    }
    
    /// Method to start the reverse animation according to the orientation of the iPhone
    private func startTheEndOfSharingAnimation() {
        
        deviceIsPortraitMode ? UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            
            self.gridPhotoLayoutContainerView.frame = self.gridPhotoLayoutContainerView.frame.offsetBy(dx: 0, dy: UIScreen.main.bounds.maxY)
        }.startAnimation() : UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            
            self.gridPhotoLayoutContainerView.frame = self.gridPhotoLayoutContainerView.frame.offsetBy(dx: UIScreen.main.bounds.maxX, dy: 0)
            
        }.startAnimation()
    }
    
    // MARK: @objc Private methods
    
    /// Method to add the photos selected by the user in the view
    @objc private func addPhotoToImageView(sender: UITapGestureRecognizer) {
        guard let viewTag = sender.view?.tag else { return }
        let clickedView = imageViews[viewTag]
        
        CameraHandler.shared.showActionSheet(viewController: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            
            clickedView.image = image
            
            for plusImageView in clickedView.subviews where clickedView.subviews.count > 0 {
                plusImageView.removeFromSuperview()
            }
            
            self.userPhotosDictionary[viewTag] = image
            self.handleSwipeGestureRecognizer()
            self.imagesFromImageViews.append(image)
        }
        
    }
    
    /// Method to launch the swipe gesture animation
    @objc private func ManageActionsAfterSwipeGestureDetection(_ sender: UISwipeGestureRecognizer) {
        startSharingAnimation()
        shareContentOfTheGrid()
    }
    
    // MARK: - Internal methods
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        cleanGridButton.isHidden = true
        initializeSwipeGesture()
        hide(stackViewGestureIndication)
        setupLayoutButtons()
    }
    
    /// Method to manage the behavior of the application when the user changes the orientation of his phone
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
            
            if windowInterfaceOrientation.isPortrait {
                self.deviceIsPortraitMode = true
            } else {
                self.deviceIsPortraitMode = false
            }
        })
        
        instagridActivityViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}
