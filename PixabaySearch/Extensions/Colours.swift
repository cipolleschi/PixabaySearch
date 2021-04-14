//
//  Colours.swift
//  PixabaySearch
//
//  Created by Andras Pal on 14/04/2021.
//

import UIKit

// Setting up a theme manager and use it in the appDelegate / VCs would be more versatile probably
public extension UIColor {
        
    static let bgColour: UIColor = colour(name: "bgColour")
    static let mainTextColour: UIColor = colour(name: "mainTextColour")

    private static func colour(name: String) -> UIColor {
        UIColor(named: name, in: Bundle.main, compatibleWith: nil)!
    }
}
