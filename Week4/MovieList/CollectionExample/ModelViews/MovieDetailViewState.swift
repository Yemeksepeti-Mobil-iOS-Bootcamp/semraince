import Foundation

struct MovieDetailViewState {
    var movieDetail: MovieDetailResponse?
    var id: Int
}
extension MovieDetailViewState {
    enum Change {
        case getDetailError(error: MoviesErrors?)
        case fetchState(fetching: Bool)
        case movieDetail
    }
}
