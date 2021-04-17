//
//  TextfieldWithPadding.swift
//  PixabaySearch
//
//  Created by Andras Pal on 17/04/2021.
//

import UIKit

final class TextFieldWithPadding: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: kUI.Spacing.medium,
        left: kUI.Spacing.large,
        bottom: kUI.Spacing.medium,
        right: kUI.Spacing.large
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
