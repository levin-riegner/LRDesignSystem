//
//  LargeDisplayCard.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 07/10/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation
import UIKit

public class LargeDisplayCard: UICollectionViewCell, NibLoadable {
    
    @IBOutlet public weak var imageView: UIImageView!
    
    @IBOutlet public weak var infoContainer: UIView!
    @IBOutlet public weak var overline: Overline!
    @IBOutlet public weak var headLine: RHeadline!
    @IBOutlet public weak var body: SBody!
    @IBOutlet public weak var bottomLabel: UILabel!
    

       override init(frame: CGRect) {
           super.init(frame: frame)
           xibSetup()
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           xibSetup()
       }
    
       func xibSetup() {
//           view = loadViewFromNib()
//           view.frame = bounds
//           view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    
//           addSubview(view)
       }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LargeDisplayCard", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
     
        return view
    }
    
//    override public var isHighlighted: Bool {
//      didSet {
//        UIView.animate(withDuration: 0.5) {
//          let scale: CGFloat = 0.9
//          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
//        }
//      }
//    }
    
    //Needed to get AUTORESIZED XIB
    override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
