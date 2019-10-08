//
//  MainAuthenticationScreen.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 25/09/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class Page2Authentication: UIView, NibLoadable {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: SHeadline!

    @IBOutlet weak var subTitle: SBody!
    
    
    @IBInspectable var imageName: UIImage? {
        get {
            return image.image
        }
        set(imageName) {
            image.image = imageName
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        
    }
    
}
