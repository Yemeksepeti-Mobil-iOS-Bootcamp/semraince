//
//  ViewController.swift
//  Movies
//
//  Created by Kerim Caglar on 3.08.2021.
//

import UIKit

class ViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var viewModel: ViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieCollectionView.register(cellType: CardViewCollectionCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.load()
    }

}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeCell(cellType: CardViewCollectionCell.self, indexPath: indexPath)
        
        if let movie = viewModel.movie(indexPath: indexPath.row) {
            cell.configure(with: movie)
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = viewModel.movie(indexPath: indexPath.row) {
            print(movie.title)
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.calculateCellHeight(collectionViewWidth: Double(collectionView.frame.size.width))
        return .init(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: CGFloat(viewModel.cellPadding), bottom: .zero, right: CGFloat(viewModel.cellPadding))
    }
}

extension ViewController: ViewModelDelegate {
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        movieCollectionView.reloadData()
    }
    
}
