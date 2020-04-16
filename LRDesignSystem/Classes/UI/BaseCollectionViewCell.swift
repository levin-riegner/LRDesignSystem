//
//  BaseCollectionViewCell.swift
//  LRDesignSystem
//
//  Created by Pedro Manfredi on 16/04/2020.
//

import Foundation
import RxSwift
class BaseCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
