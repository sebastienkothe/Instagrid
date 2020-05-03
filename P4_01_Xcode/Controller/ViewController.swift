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
    
    /// ActivityViewController. Used to share the grid
    private var ac : UIActivityViewController!
    
    /// The screenshot from the grid
    private let gridScreenshot: UIImage! = nil
    
    // Tags to identify the elements
    private var tagPlusImageViews = 0
    
    private var tagImageView = 0 {
        willSet {
            tagPlusImageViews = tagImageView
        }
    }
    
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
    private var imageViews: [UIImageView] = []
    
    private var imagesFromImageViews: [UIImage] = [] {
        didSet {
            cleanGridButton.isHidden = imagesFromImageViews.count > 0 ? false : true
            stackViewGestureIndication.isHidden = cleanGridButton.isHidden ? true : false
        }
    }
    
    private var plusImageViews: [UIImageView] = []
    private var dico = [Int: UIImage]()
    
    // MARK: Private action
    @IBAction private func didTapOnLayoutButton(_ sender: UIButton) {
        
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
        
        plusImageViews.removeAll()
        
        mainSquare.removeGestureRecognizer(mySwipeGestureRecognizer)
        dico.removeAll()
        imagesFromImageViews.removeAll()
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
        plusImageViews.removeAll()
        imageViews.removeAll()
        
        /// Reset tag
        tagImageView = 0
    }
    
    private func addUserImagesToNewLayout() {
        
        for (tag, image) in dico {
            if tag + 1 > whiteViews.count {
                continue
            }
            
            imageViews[tag].image = image
            imageViews[tag].subviews[0].removeFromSuperview()
        }
        
    }
    
    private func setupLayoutButtons() {
        for (index, button) in layoutButtons.enumerated() {
            button.tag = index
            setupLayoutButtonImage(button: button)
        }
    }
    
    private func handlePhotoLayoutButtonSelection(selectedTag: Int) {
        for button in layoutButtons {
            button.isSelected = button.tag == selectedTag
        }
    }
    
    private func setupLayoutButtonImage(button: UIButton) {
        button.setImage(nil, for: .normal)
        button.setImage(UIImage(named: "Selected"), for: .selected)
    }
    
    private func setupGridLayoutView(layout: PhotoLayout) {
        
        addWhiteViewsTo(stackView: topStackView, numberOfViews: layout.numberOfTopView)
        addWhiteViewsTo(stackView: botStackView, numberOfViews: layout.numberOfBotView)
        addUserImagesToNewLayout()
    }
    
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
    
    private func addImageViewTo(_ whiteView: UIView) {
        let imageView = UIImageView()
        
        whiteView.addSubview(imageView)
        imageViews.append(imageView)
        
        setupImageView(imageView, whiteView)
        addTapGestureRecognizerToImageViews(imageView: imageView)
        addPlusImageTo(imageView)
    }
    
    private func setupImageView(_ imageView: UIImageView, _ whiteView: UIView) {
        
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
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
    
    private func sharedShareAction() {
        
        present(ac,animated: true, completion: nil)
        
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
            sharedShareAction()
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
    
    private func initializeSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(launchTheSwipeGestureAnimation(_:)))
        mySwipeGestureRecognizer = swipeGesture
        deviceIsPortraitMode = size.width < size.height ? true : false
        
    }
    
    private func launchTheAnimation() {
        deviceIsPortraitMode ? animations[0].startAnimation() : animations[1].startAnimation()
    }
    
    private func launchTheReverseAnimation() {
        deviceIsPortraitMode ? animations[2].startAnimation() : animations[3].startAnimation()
    }
    
    // MARK: @objc Private methods
    @objc private func addPhotoToImageView(sender: UITapGestureRecognizer) {
        guard let viewTag = sender.view?.tag else { return }
        let clickedView = imageViews[viewTag]
        
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            
            clickedView.image = image
            
            for plusImageView in clickedView.subviews where clickedView.subviews.count > 0 {
                plusImageView.removeFromSuperview()
            }
            
            self.dico[viewTag] = image
            self.imagesFromImageViews.append(image)
            self.stackViewGestureIndication.isHidden = false
            self.mainSquare.addGestureRecognizer(self.mySwipeGestureRecognizer)
        }
    }
    
    @objc private func launchTheSwipeGestureAnimation(_ sender: UISwipeGestureRecognizer) {
        launchTheAnimation()
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
    
    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        deviceIsPortraitMode = UIDevice.current.orientation.isPortrait ? true : false
        
        if ac != nil {
            ac.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
