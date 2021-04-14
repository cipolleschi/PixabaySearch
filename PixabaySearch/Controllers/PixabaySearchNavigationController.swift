//
//  PixabaySearchNavigationController.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

class PixabaySearchNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationBar.barStyle = .default
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
    }
}
