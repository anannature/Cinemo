//
//  MoviesTableViewCell.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        background.layer.cornerRadius = 12
        bannerImage.layer.cornerRadius = 12
        bannerImage.contentMode = .scaleAspectFill
    }
    
    func configure(with data: Movie) {
        typeLabel.text = data.genre
        titleLabel.text = data.title
       
        bannerImage.loadImage(fromURL: data.poster_url ?? "")
        if let formattedDate = data.release_date?.formatDateToCustom() {
            dateLabel.text = formattedDate
        }
    }
    
}





