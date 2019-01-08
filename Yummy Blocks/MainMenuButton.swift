//
//  MainMenuButton.swift
//  Yummy Blocks
//
//  Created by Jonathan Chin on 1/7/19.
//  Copyright © 2019 goplaychess. All rights reserved.
//

import UIKit

class MainMenuButton: UIButton {
    var action: (() -> Void)?
    
    func whenButtonIsClicked(action: @escaping () -> Void) {
        self.action = action
        self.addTarget(self, action: #selector(MainMenuButton.clicked), for: .touchUpInside)
    }
    
    // Button Event Handler:
    // I have not marked this as @IBAction because it is not intended to
    // be hooked up to Interface Builder
    @objc func clicked() {
        action?()
    }
}
