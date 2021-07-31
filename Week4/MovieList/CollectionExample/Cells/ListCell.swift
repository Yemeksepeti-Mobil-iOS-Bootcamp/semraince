import UIKit

class ListCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    
    let resourceString = "https://image.tmdb.org/t/p/w200"
    func configure(with model: Movie?) {
        titleLabel.text = model?.original_title
        if let posterPath = model?.poster_path {
            guard let resourceURL = URL(string: resourceString + posterPath) else {
                fatalError()
            }
            imageView.load(url: resourceURL)
        }
        starImage.isHidden = !(model?.isFavorite ?? false)
      
        
    }
    
}
