//
//  UICollectionViewCell.swift
//  Movies
//
//  Created by Kerim Caglar on 5.08.2021.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
