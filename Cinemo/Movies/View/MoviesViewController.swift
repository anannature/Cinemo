//
//  MoviesViewController.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var movieFinder: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    let viewModel: MoviesViewModelProtocol = MoviesViewModel()
    let moviesTableViewCell = "MoviesTableViewCell"
    var filteredMovies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regusterCell()
        setupView()
        viewModel.input.getMovies()
        
        movieFinder.delegate = self
        movieFinder.addTarget(self, action: #selector(filterMovies), for: .allEvents)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        topBarView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      topBarView.isHidden = false
        
      navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.input.didFetchList = { [weak self] in
            DispatchQueue.main.async {
                self?.filteredMovies = self?.viewModel.output.data ?? []
                self?.tableView.reloadData()
            }
        }
        
        viewModel.input.onLoadingStatusChange = { [weak self] isLoading in
            if isLoading {
                self?.showLoadingIndicator()
            } else {
                self?.hideLoadingIndicator()
            }
        }
    }
    
    @objc func filterMovies() {
        let searchText = movieFinder.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if searchText.isEmpty {
            filteredMovies = viewModel.output.data
        } else {
            filteredMovies = viewModel.output.data.filter { movie in
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
        let movie = filteredMovies[index.row]
        let detailsVC = MoviesDetailsViewController(movie: movie)
            self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func goToMoviesFavorite() {
        let favoriteVC = MoviesFavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        goToMoviesFavorite()
    }
    
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: moviesTableViewCell, for: indexPath) as? MoviesTableViewCell else {
            fatalError("Failed to dequeue MoviesTableViewCell")
        }
        cell.selectionStyle = .none

        let movie = filteredMovies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMoviesDetails(index: indexPath)
    }
}

extension MoviesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

