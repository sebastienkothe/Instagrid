//
//  PhotoLayoutProvider.swift
//  P4_01_Xcode
//
//  Created by Sébastien Kothé on 25/04/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit

class PhotoLayoutProvider {
    var photoLayouts: [PhotoLayout] =  [
        PhotoLayout(numberOfTopView: 2, numberOfBotView: 1),
        PhotoLayout(numberOfTopView: 1, numberOfBotView: 2),
        PhotoLayout(numberOfTopView: 2, numberOfBotView: 2)
    ]
}
