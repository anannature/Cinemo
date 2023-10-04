//
//  Extension+UINavigationItem.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import UIKit

extension UIViewController {
    
    func addBarButton(title: String) {
           let titleLabel = UILabel()
           titleLabel.text = title
           titleLabel.textColor = .white
           
        self.navigationItem.titleView = titleLabel
       }
    
}
