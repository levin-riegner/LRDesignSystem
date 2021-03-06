//
//  Caption.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 25/09/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class Caption: UIView, NibLoadable {
    
    @IBOutlet weak public var label: UILabel!
    
    @IBInspectable
    public var text: String = "" {
        didSet{
            label.text = text
        }
    }
    
    public var attributedText: NSAttributedString? {
        didSet{
            label.attributedText = attributedText
        }
    }
    
    var typeOfAlignment = TypeOfAlignment.left
    
    @IBInspectable private var alignment : String {
        set {
            typeOfAlignment = TypeOfAlignment(rawValue: newValue) ?? .left
            setup()
        }
        get {
            return typeOfAlignment.rawValue
        }
    }
    
    func setup(style: String = "GC") {
        //depending on the type
        switch typeOfAlignment {
        case .left  :
            label.textAlignment = .left
        case .center      :
            label.textAlignment = .center
        case .right    :
            label.textAlignment = .right
        }
        switch style {
        case "GC":
            label.font = .caption
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        setup()
    }
    
}
