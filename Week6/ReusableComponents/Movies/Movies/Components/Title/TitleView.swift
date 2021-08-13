//
//  TitleView.swift
//  Movies
//
//  Created by semra on 14.08.2021.
//

import UIKit


class TitleView: UIView {
    
    @IBOutlet weak var title: UILabel!
    
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
    }
    
    func configure(with text: String) {
        title.text = text;
        
    }
    
    
    
  
}
