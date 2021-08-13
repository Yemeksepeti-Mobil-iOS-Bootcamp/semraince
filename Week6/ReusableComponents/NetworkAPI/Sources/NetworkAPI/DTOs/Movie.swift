//
//  Movie.swift
//  
//
//  Created by Kerim Caglar on 1.08.2021.
//

import Foundation

public struct MovieResults: Decodable {
    public let page: Int
    public let results: [Movie]
    public let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Decodable {
    public let id: Int
    public let overview: String
    public let posterPath: String
    public let releaseDate: String?
    public let title: String
    public let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
