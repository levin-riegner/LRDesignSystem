//
//  RBody.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 25/09/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class Overline: UIView, NibLoadable {
    
    @IBOutlet public weak var label: UILabel!
    
    @IBInspectable
    public var text: String = "" {
        didSet{
            label.font = .button
            label.attributedText = NSAttributedString(string: text, attributes: [.kern: 0.5])
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
    
    func setup() {
        //depending on the type
        switch typeOfAlignment {
        case .left  :
            label.textAlignment = .left
        case .center      :
            label.textAlignment = .center
        case .right    :
            label.textAlignment = .right
        }
        label.font = .overline
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
