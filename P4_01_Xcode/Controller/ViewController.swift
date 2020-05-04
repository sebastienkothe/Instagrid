//
//  ViewController.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 18/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Internal properties
    
    /// Not private because used in PropertyAnimators.swift
    @IBOutlet weak var mainSquare: UIView!
    
    // MARK: - Private properties
    private let photoLayoutProvider = PhotoLayoutProvider()
    
    // Device screen informations
    private let size = UIScreen.main.bounds.size
    
    /// The swipe gesture recognizer
    private var mySwipeGestureRecognizer: UISwipeGestureRecognizer!
    
    /// The screenshot from the grid
    private let gridScreenshot: UIImage! = nil
    
    /// ActivityViewController. Used to share the grid
    var ac : UIActivityViewController! = nil
    
    /// To check whether the application went into the background or not
    private var isAppMovedToBackground = false
    
    // Tags to identify the elements
    private var tagPlusImageViews = 0
    
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
    /// Property used to change the direction of the swipe gesture recognizer
    private var deviceIsPortraitMode = false {
        didSet {
            mySwipeGestureRecognizer.direction = deviceIsPortraitMode ? .up : .left
        }
    }
    
    // MARK: Private outlet
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var botStackView: UIStackView!
    @IBOutlet private weak var stackViewGestureIndication: UIStackView!
    @IBOutlet private weak var cleanGridButton: UIButton!
    
    /// Bottom buttons' Outlet Collection
    @IBOutlet private var layoutButtons: [UIButton]!
    
    // mainSquare's children
    private var whiteViews: [UIView] = []
    
    private var numberOfWhiteViews = 0
    
    private var imageViews: [UIImageView] = []
    private var plusImageViews: [UIImageView] = []
    private var imagesFromImageViews: [UIImage] = [] {
        didSet {
            cleanGridButton.isHidden = imagesFromImageViews.count > 0 ? false : true
        }
    }
    
    /// Used to save grid images
    private var userPhotosDictionary: [Int: UIImage] = [:]
    
    // MARK: Private action
    @IBAction private func didTapOnLayoutButton(_ sender: UIButton) {
        mainSquare.addGestureRecognizer(mySwipeGestureRecognizer)
        
        cleanGridLayoutView()
        
        handlePhotoLayoutButtonSelection(selectedTag: sender.tag)
        
        let layout = photoLayoutProvider.photoLayouts[sender.tag]
        setupGridLayoutView(layout: layout)
    }
    
    @IBAction private func cleanImagesFromTheGrid() {
        
        for imageView in imageViews {
            imageView.image = nil
            addPlusImageTo(imageView)
        }
        
        imagesFromImageViews.removeAll()
        plusImageViews.removeAll()
        userPhotosDictionary.removeAll()
        handleTheSwipeGestureRecognizer()
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
        for (index, button) in layoutButtons.enumerated() {
            button.tag = index
            setupLayoutButtonImage(button: button)
        }
    }
    
    /// Method to manage if the button is selected or not
    private func handlePhotoLayoutButtonSelection(selectedTag: Int) {
        for button in layoutButtons {
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
        
        addWhiteViewsTo(stackView: topStackView, numberOfViews: layout.numberOfTopView)
        addWhiteViewsTo(stackView: botStackView, numberOfViews: layout.numberOfBotView)
        addUserImagesToNewLayout()
        numberOfWhiteViews = whiteViews.count
        handleTheSwipeGestureRecognizer()
    }
    
    /// Method to to prevent the user from sharing an empty grid
    private func handleTheSwipeGestureRecognizer() {
        
        guard !(numberOfWhiteViews == 3 && userPhotosDictionary.count == 1 &&  userPhotosDictionary.index(forKey: 3) != nil) else {
            handleStateOfTheSwipeGesture(state: "Off")
            print("Off")
            return
        }
        
        guard !(numberOfWhiteViews == 4 && userPhotosDictionary.count == 1 &&  userPhotosDictionary.index(forKey: 3) != nil) else {
            handleStateOfTheSwipeGesture(state: "On")
            print("On")
            return
        }
        
        guard userPhotosDictionary.count >= 1 else {
            handleStateOfTheSwipeGesture(state: "Off")
            print("Off")
            return
        }
        
        guard userPhotosDictionary.count < 1 else {
            handleStateOfTheSwipeGesture(state: "On")
            print("On")
            return
        }
        
    }
    
    /// Method to handle the state of the swipe gesture
    private func handleStateOfTheSwipeGesture(state: String) {
        if state == "On" {
            stackViewGestureIndication.isHidden = false
            mySwipeGestureRecognizer.isEnabled = true
        } else {
            stackViewGestureIndication.isHidden = true
            mySwipeGestureRecognizer.isEnabled = false
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhotoToImageView(sender:)))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        imageView.tag = tagImageView
        
        tagImageView += 1
    }
    
    /// Method to handle the UIActivityViewController
    private func handleTheActivityViewController() {
        
        // To present it
        present(ac,animated: true, completion: nil)
        
        // To handle the completion
        ac.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed || !completed {
                self.ac.dismiss(animated: true) {
                    self.launchTheReverseAnimation()
                }
                return
            }
        }
    }
    
    /// Method to share the screenshot
    private func shareContentOfTheGrid() {
        
        switch mySwipeGestureRecognizer.state {
        case .ended:
            let items = [screenShotMethod()]
            
            ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            
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
        let renderer = UIGraphicsImageRenderer(size: mainSquare.bounds.size)
        let image = renderer.image { ctx in
            mainSquare.drawHierarchy(in: mainSquare.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    /// Method to initialize the swipe gesture recognizer
    private func initializeSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(launchTheSwipeGestureAnimation(_:)))
        mySwipeGestureRecognizer = swipeGesture
        deviceIsPortraitMode = size.width < size.height ? true : false
        
    }
    
    /// Method to start the animation according to the orientation of the iPhone
    private func launchTheAnimation() {
        deviceIsPortraitMode ? animations[0].startAnimation() : animations[1].startAnimation()
    }
    
    /// Method to start the reverse animation according to the orientation of the iPhone
    private func launchTheReverseAnimation() {
        deviceIsPortraitMode ? animations[2].startAnimation() : animations[3].startAnimation()
    }
    
    /// Method to check if a view is visible or no
    private func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
    
    // MARK: @objc Private methods
    
    /// Method to add the photos selected by the user in the view
    @objc private func addPhotoToImageView(sender: UITapGestureRecognizer) {
        guard let viewTag = sender.view?.tag else { return }
        let clickedView = imageViews[viewTag]
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            
            clickedView.image = image
            
            for plusImageView in clickedView.subviews where clickedView.subviews.count > 0 {
                plusImageView.removeFromSuperview()
            }
            
            self.userPhotosDictionary[viewTag] = image
            self.handleTheSwipeGestureRecognizer()
            self.imagesFromImageViews.append(image)
        }
    }
    
    /// Method to launch the swipe gesture animation
    @objc private func launchTheSwipeGestureAnimation(_ sender: UISwipeGestureRecognizer) {
        launchTheAnimation()
        shareContentOfTheGrid()
    }
    
    /// Method to manage the behavior of the UIActivityViewController if the application is moved in the background
    @objc func backgroundCall() {
        isAppMovedToBackground = true
        
        if ac != nil {
            ac.dismiss(animated: true, completion: {
                if !self.isVisible(view: self.mainSquare) {
                    self.launchTheReverseAnimation()
                }
            })
        }
    }
    
    /// Method to manage the behavior of the application when the user is in the foreground
    @objc func foregroundCall() {
        isAppMovedToBackground = false
    }
    
    // MARK: - Internal methods
    override internal func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(backgroundCall), name: UIApplication.willResignActiveNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(foregroundCall), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        cleanGridButton.isHidden = true
        initializeSwipeGesture()
        hide(stackViewGestureIndication)
        setupLayoutButtons()
    }
    
    /// Method to manage the behavior of the application when the user changes the orientation of his phone
    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        deviceIsPortraitMode = UIDevice.current.orientation.isPortrait ? true : false
        
        if ac != nil {
            ac.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
