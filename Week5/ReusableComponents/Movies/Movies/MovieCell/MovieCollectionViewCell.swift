//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Kerim Caglar on 3.08.2021.
//

import UIKit
import NetworkAPI
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: Movie) {
        preparePosterImage(with: movie.posterPath)
        title.text = movie.title
    }
    
    private func preparePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        if let url = URL(string: fullPath) {
            movieImage.sd_setImage(with: url, completed: nil)
        }
    }

}
