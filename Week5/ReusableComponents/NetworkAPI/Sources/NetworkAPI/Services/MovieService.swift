//
//  MovieService.swift
//  
//
//  Created by Kerim Caglar on 3.08.2021.
//

import Foundation
import Alamofire


public protocol MovieServiceProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void )
}

public class PopularMoviesService: MovieServiceProtocol {
    
    public init() {}
    
    public func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let urlString = "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=1"
        
        AF.request(urlString).responseData { (response) in
            switch response.result {
            case .success(let data):
                
                let decoder = Decoders.dateDecoder
                
                do {
                    let response = try decoder.decode(PopularMovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch  {
                    print("Decode işleminde bir hata meydana geldi")
                }
                
                
            case .failure(let error):
                print("Ağ ayarlarınızı kontrol ediniz.")
            }
        }
        
    }
    
    
}
