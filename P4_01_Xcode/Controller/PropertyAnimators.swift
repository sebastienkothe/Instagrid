//
//  PropertyAnimators.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 01/05/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit


extension ViewController {
    var animations: [UIViewPropertyAnimator] {
        
        [
            UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                
                self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: 0, dy: -UIScreen.main.bounds.maxY)
            }, UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                
                self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: -UIScreen.main.bounds.maxX, dy: 0)
            }, UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                
                self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: 0, dy: UIScreen.main.bounds.maxY)
            }, UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
                
                self.mainSquare.frame = self.mainSquare.frame.offsetBy(dx: UIScreen.main.bounds.maxX, dy: 0)
            }
        ]
        
    }
    
}
