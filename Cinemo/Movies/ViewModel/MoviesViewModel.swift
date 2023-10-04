//
//  MoviesViewModel.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import Foundation

protocol MoviesViewModelProtocol: AnyObject {

    var input: MoviesViewModelInput { get }
    var output: MoviesViewModelOutput { get }
}

protocol MoviesViewModelInput: AnyObject {

    var didFetchList: (() -> Void)? { get set }
    var onLoadingStatusChange: ((Bool) -> Void)? { get set }

    func getMovies()
}

protocol MoviesViewModelOutput: AnyObject {

    var data: [Movie]  { get }
}
class MoviesViewModel: MoviesViewModelProtocol {

    var input: MoviesViewModelInput { self }
    var output: MoviesViewModelOutput { self }
//    let movieService = MovieService()
    var data: [Movie] = []
    var didFetchList: (() -> Void)?
    var onLoadingStatusChange: ((Bool) -> Void)?
    
    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func getMovies() {
        onLoadingStatusChange?(true)
        
        movieService.fetchMovies { result in
            DispatchQueue.main.async {
                self.onLoadingStatusChange?(false)
                switch result {
                case .success(let movies):
                    self.data = movies
                    self.didFetchList?()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

extension MoviesViewModel: MoviesViewModelInput {}
extension MoviesViewModel: MoviesViewModelOutput {}
