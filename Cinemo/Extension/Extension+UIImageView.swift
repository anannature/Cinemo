//
//  Extension+UIImageView.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: String) {
        if let imageURL = URL(string: url) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
                if error == nil, let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}


