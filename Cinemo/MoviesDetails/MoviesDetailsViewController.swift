//
//  MoviesDetailsViewController.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

class MoviesDetailsViewController: UIViewController {

    var movie: Movie
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupView() {
        
        addBarButton(title: "Cinemo")
        
        bannerImage.layer.cornerRadius = 12
        favoriteButton.layer.cornerRadius = 12
        bannerImage.clipsToBounds = true
        bannerImage.contentMode = .scaleAspectFill
        
        typeLabel.text = movie.genre
        titleLabel.text = movie.title
        detailsLabel.text = movie.synopsis
        bannerImage.loadImage(fromURL: movie.poster_url ?? "")
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        goToMoviesFavorite()
    }
    
    private func goToMoviesFavorite() {
        MoviesData.favoriteMovies.append(movie)
        let favoriteVC = MoviesFavoriteViewController()
    
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
}
