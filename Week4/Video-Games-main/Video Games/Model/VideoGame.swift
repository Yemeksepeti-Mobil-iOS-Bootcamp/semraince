import Foundation
import UIKit

struct VideoGameList: Decodable {
    let next: String
    let results: [VideoGame]
}

struct VideoGame: Decodable {
    let slug: String
    let name: String
    let released: String
    let background_image: String
    let rating: Double
    let description: String?
    let metacritic: Int?
}
