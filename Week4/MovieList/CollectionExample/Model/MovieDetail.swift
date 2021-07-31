import Foundation

struct MovieDetailResponse: Codable {
    var id: Int?
    var poster_path: String?
    var vote_average: Float?
    var vote_count: Int?
    var original_title: String?
    var release_date: String?
    var overview: String?
    var isFavorite: Bool? {
        let defaults = UserDefaults.standard
        let favMovies = defaults.array(forKey: "movies") as? [Int]
        return favMovies?.contains(id ?? 0)
    }
}
