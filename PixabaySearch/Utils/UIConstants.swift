//
//  UIConstants.swift
//  PixabaySearch
//
//  Created by Andras Pal on 17/04/2021.
//

import UIKit

/// UI element size constants
enum kUI {

    enum ImageSize {
        static let large: CGFloat = 300
        static let regular: CGFloat = 150
        static let small: CGFloat = 50
        static let largeSquare: CGSize = CGSize(width: kUI.ImageSize.large, height: kUI.ImageSize.large)
        static let regularSquare: CGSize = CGSize(width: kUI.ImageSize.regular, height: kUI.ImageSize.regular)
        static let smallSquare: CGSize = CGSize(width: kUI.ImageSize.small, height: kUI.ImageSize.small)
    }

    enum Padding {
        static let defaultPadding: CGFloat = 20
        static let labelContentPadding: CGFloat = 10
        static let largePadding: CGFloat = 30
    }
    
    enum Spacing {
        static let small: CGFloat = 5
        static let medium: CGFloat = 10
        static let large: CGFloat = 20
    }
    
    enum Size {
        static let screenSize: CGRect = UIScreen.main.bounds
        static let regularFont: CGFloat = 24
        static let smallFont: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let textFieldHeight: CGFloat = 60
        static let searchButtonHeight: CGFloat = 60
        static let pixaLogoHeight: CGFloat = 40
    }
}

