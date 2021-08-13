//
//  ViewModel.swift
//  Movies
//
//  Created by Kerim Caglar on 7.08.2021.
//

import Foundation
import NetworkAPI


extension ViewModel {
    
    fileprivate enum Constants {
        static let cellTitleHeight: Double = 50
        static let cellPosterImageRatio: Double = 1/2
        static let cellLeftPadding: Double = 15
        static let cellRightPadding: Double = 15
    }
}

protocol ViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    var cellPadding: Double { get }
    func load()
    func movie(indexPath: Int) -> Movie?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
}

protocol ViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class ViewModel {
    
    private var movies: [Movie] = []

    let service: MovieServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchMovies() {
        delegate?.showLoadingView()
        service.fetchPopularMovies { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let movies):
                print(movies)
                self.movies = movies
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension ViewModel: ViewModelProtocol {
    
    var numberOfItems: Int {
        movies.count
    }
    
    var cellPadding: Double {
        Constants.cellLeftPadding
    }
    
    func load() {
        fetchMovies()
    }
    
    func movie(indexPath: Int) -> Movie? {
        movies[safe: indexPath]
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        let cellWidht = collectionViewWidth - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let posterImageHeight = cellWidht * Constants.cellPosterImageRatio
        
        return (width: cellWidht, height: Constants.cellTitleHeight + posterImageHeight)
    }
    
    
}
