//
//  mySickButton.swift
//  Conversion Calculator
//
//  Created by Xcode User on 10/2/19.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit

class mySickButton: UIButton {

    override func awakeFromNib() {
        self.tintColor = BACKGROUND_COLOR
        self.backgroundColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
    }
}
