//
//  CardViewCollectionCellCollectionViewCell.swift
//  Movies
//
//  Created by semra on 14.08.2021.
//

import UIKit
import NetworkAPI

class CardViewCollectionCell: UICollectionViewCell {
    
   
    @IBOutlet weak var cardView: CardView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: Movie) {
        cardView.configure(with: model)
    }
}
