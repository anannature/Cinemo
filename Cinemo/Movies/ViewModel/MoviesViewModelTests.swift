//
//  MoviesViewModelTests.swift
//  CinemoTests
//
//  Created by Anan Kaewsaart on 5/10/2566 BE.
//

import XCTest
@testable import Cinemo


class MoviesViewModelTests: XCTestCase {
    
    func testFetchMovies() {
        let movieService = MovieService()
        let viewModel = MoviesViewModel(movieService: movieService)
        
        let expectation = XCTestExpectation(description: "Fetching movies")
        
        viewModel.input.didFetchList = {
            expectation.fulfill()
        }
        
        viewModel.getMovies()
  
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testService() {
        let movieService = MovieService()
        
        let expectation = XCTestExpectation(description: "Fetching movies")
        
        movieService.fetchMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch movies with error: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
