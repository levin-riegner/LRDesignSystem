//
//  LargeDisplayCard.swift
//  GlobalCitizenComponents
//
//  Created by Pedro Manfredi on 07/10/2019.
//  Copyright © 2019 Pedro Manfredi. All rights reserved.
//

import Foundation

class LargeDisplayCard: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var overline: Overline!
    @IBOutlet weak var headLine: RHeadline!
    @IBOutlet weak var body: SBody!
    @IBOutlet weak var counterViewersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isHighlighted: Bool {
      didSet {
        UIView.animate(withDuration: 0.5) {
          let scale: CGFloat = 0.9
          self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
        }
      }
    }
    
    //Needed to get AUTORESIZED XIB
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
