//
//  MoviesFavoriteViewController.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

class MoviesFavoriteViewController: UIViewController {

    @IBOutlet weak var movieFinder: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let moviesTableViewCell = "MoviesTableViewCell"
    var movie: [Movie]?
    var filteredMovies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regusterCell()
        movie = MoviesData.favoriteMovies
        filteredMovies = movie
        movieFinder.delegate = self
        movieFinder.addTarget(self, action: #selector(filterMovies), for: .allEvents)
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        addBarButton(title: "Cinemo")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func filterMovies() {
        let searchText = movieFinder.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if searchText.isEmpty {
            filteredMovies = movie
        } else {
            filteredMovies = movie?.filter { movie in
                let title = movie.title.lowercased()
                return title.contains(searchText.lowercased())
            }
        }
        
        tableView.reloadData()
    }
    
    private func regusterCell() {
        tableView.register(UINib(nibName: moviesTableViewCell, bundle: nil), forCellReuseIdentifier: moviesTableViewCell)
    }
    
    private func goToMoviesDetails(index: IndexPath) {
        guard let movie = filteredMovies?[index.row] else { return }
        let detailsVC = MoviesDetailsViewController(movie: movie)
    
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension MoviesFavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: moviesTableViewCell, for: indexPath) as? MoviesTableViewCell else {
            fatalError("Failed to dequeue MoviesTableViewCell")
        }
        cell.selectionStyle = .none

        if let movie = filteredMovies?[indexPath.row] {
            cell.configure(with: movie)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMoviesDetails(index: indexPath)
    }
}

extension MoviesFavoriteViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
