//
//  BoxButton.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 25/09/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class BaseButtonIssue: UIView, NibLoadable {
    
    @IBInspectable
    public var title: String = "" {
        didSet{
            mainTitle.text = title
        }
    }
    
    @IBInspectable
    public var imageOn: UIImage? = UIImage(named: "introLogo") {
        didSet{
            if isSelected {
                mainImage.image = imageOn
            }
        }
    }
    
    
    @IBInspectable
    public var imageOff: UIImage? = UIImage(named: "introLogo") {
        didSet{
            if !isSelected {
                mainImage.image = imageOff
            }
        }
    }
    
    @IBInspectable
    public var isSelected: Bool = false {
        didSet{
            if isSelected {
                self.backgroundColor = backgroundColorOn
                self.mainTitle.textColor = textColorOn
                self.mainImage.image = imageOn
            } else {
                self.backgroundColor = backgroundColorOff
                self.mainTitle.textColor = textColorOff
                self.mainImage.image = imageOff
            }
        }
    }
    
    @IBInspectable
    public var backgroundColorOn: UIColor? = UIColor.red {
        didSet{
            if isSelected {
                self.backgroundColor = backgroundColorOn
            }
        }
    }
    
    @IBInspectable
    public var backgroundColorOff: UIColor? = UIColor.red {
        didSet{
            if !isSelected {
                self.backgroundColor = backgroundColorOff
            }
        }
    }
    
    @IBInspectable
    public var textColorOn: UIColor? = UIColor.red {
        didSet{
            if isSelected {
                self.mainTitle.textColor = textColorOn
            }
        }
    }
    
    @IBInspectable
    public var textColorOff: UIColor? = UIColor.red {
        didSet{
            if !isSelected {
                self.backgroundColor = textColorOff
            }
        }
    }
    
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    //    @IBInspectable
    //    public var selected: Bool = false {
    //        didSet {
    //            if selected {
    //                mainTitle.textColor = textColorSelected
    //                self.superview?.backgroundColor = backgroundSelected
    //            } else {
    //                mainTitle.textColor = textColorUnselected
    //                self.superview?.backgroundColor = backgroundUnselected
    //            }
    //        }
    //    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        //setPropierties()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        //setPropierties()
    }
    
    private func setPropierties() {
        //image.image = imageString
        //title.text = textString
    }
    
    
    
    
}
