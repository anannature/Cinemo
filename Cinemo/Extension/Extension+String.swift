//
//  Extension+String.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import Foundation

extension String {
    
    func formatDateToCustom() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d, yyyy"
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}
