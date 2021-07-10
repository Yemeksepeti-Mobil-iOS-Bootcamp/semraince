//
//  ItemViewCell.swift
//  ImageTableView
//
//  Created by semra on 9.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    func configure(itemModel : ItemModel){
        itemNameLabel.text = itemModel.name;
        imageCell.image = itemModel.image;
        
    }
    
}
