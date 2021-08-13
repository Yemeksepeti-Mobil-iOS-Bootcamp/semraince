//
//  PopularMovieResponse.swift
//  
//
//  Created by Kerim Caglar on 1.08.2021.
//

import Foundation

public struct PopularMovieResponse: Decodable {
   
    public let results: [Movie]
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Movie].self, forKey: .results)
    }
}
