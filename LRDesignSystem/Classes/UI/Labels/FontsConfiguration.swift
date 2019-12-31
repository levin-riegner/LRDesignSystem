//
//  Fonts.swift
//  GlobalCitizen
//
//  Created by Pedro Manfredi on 19/09/2019.
//  Copyright © 2019 GlobalCitizen. All rights reserved.
//

import Foundation
extension UIFont {
    class var headlineXLarge: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 30.0) ?? UIFont.systemFont(ofSize: 30)
    }
    class var headlineLarge: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 24.0) ?? UIFont.systemFont(ofSize: 24)
    }
    class var headlineRegular: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 20.0) ??
        UIFont.systemFont(ofSize: 20)
    }
    class var headlineSmall: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 18.0)! ??
        UIFont.systemFont(ofSize: 18)
    }
    class var bodyLarge: UIFont {
        return UIFont(name: "Lato-Regular", size: 18.0) ??
        UIFont.systemFont(ofSize: 18)
    }
    class var bodyRegular: UIFont {
        return UIFont(name: "Lato-Regular", size: 16.0) ??
        UIFont.systemFont(ofSize: 16)
    }
    class var button: UIFont {
        print(UIScreen.main.bounds.height, "asd")
        if UIScreen.main.bounds.height < 570 {
            return UIFont(name: "MarkOffcPro-Heavy", size: 11) ?? UIFont.systemFont(ofSize: 11)

        }
        return UIFont(name: "MarkOffcPro-Heavy", size: 14.0) ??
        UIFont.systemFont(ofSize: 16)
    }
    class var bodySmall: UIFont {
        return UIFont(name: "Lato-Regular", size: 14.0) ??
        UIFont.systemFont(ofSize: 14)
    }
    class var overline: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 12.0) ??
        UIFont.systemFont(ofSize: 12)
    }
    class var caption: UIFont {
        return UIFont(name: "Lato-Regular", size: 12.0) ??
        UIFont.systemFont(ofSize: 12)
    }
    class var label: UIFont {
        return UIFont(name: "MarkOffcPro-Bold", size: 9.0) ??
        UIFont.systemFont(ofSize: 9)
    }
}

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UILabel{
func setCharacterSpacing(_ spacing: CGFloat){
    let attributedStr = NSMutableAttributedString(string: self.text ?? "")
    attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
    self.attributedText = attributedStr
 }
}

extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}

extension UILabel {

    // MARK: - spacingValue is spacing that you need
    func addInterlineSpacing(spacingValue: CGFloat = 2) {

        // MARK: - Check if there's any text
        guard let textString = text else { return }

        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)

        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()

        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue

        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))

        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }

}
