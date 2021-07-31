import Foundation


struct MoviesResponse: Codable {
    var results: [Movie]?
}

struct Movie: Codable, Equatable {
    var id: Int?
    var original_title: String?
    var title: String?
    var poster_path: String?
    var isFavorite: Bool? {
        let defaults = UserDefaults.standard
        let favMovies = defaults.array(forKey: "movies") as? [Int]
        return favMovies?.contains(id ?? 0)
    }
}
