//
//  MovieService.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let url = URL(string: "https://www.majorcineplex.com/apis/get_movie_avaiable") {
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "Data Error", code: 0, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                    
                    let movies = moviesResponse.movies
                    
                    completion(.success(movies))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}

