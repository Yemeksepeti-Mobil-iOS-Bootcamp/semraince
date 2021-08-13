//
//  CardView.swift
//  Movies
//
//  Created by semra on 14.08.2021.
//

import UIKit
import NetworkAPI
import SDWebImage

class CardView: UIView {
    
    
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemTitle: TitleView!
    
    
    private enum Constants {
        static let borderWidth: CGFloat = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let view = self.nibInstantiate(autoResizingMask: [.flexibleHeight,
                                                          .flexibleWidth])
        view.frame = self.bounds
        addSubview(view)
        setupUI()
    
    }
    
    private func setupUI() {
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func configure(with model: Movie) {
        
        preparePosterImage(with: model.posterPath)
        
        itemTitle.configure(with: model.title);
    }
    
    
    
    private func preparePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        if let url = URL(string: fullPath) {
            itemImage.sd_setImage(with: url, completed: nil)
        }
    }
    
}
