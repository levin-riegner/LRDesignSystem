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
class TextButton: UIView, NibLoadable {
    
    @IBOutlet weak var button: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
}
