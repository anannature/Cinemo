//
//  Movie.swift
//  Cinemo
//
//  Created by Anan Kaewsaart on 4/10/2566 BE.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let movieCode: [String] = []
    let rating: String?
    let rating_id: Int?
    let duration: Int?
    let release_date: String?
    let sneak_date: String?
    let director: String?
    let actor: String?
    let genre: String?
    let poster_ori: String?
    let poster_url: String?
    let trailer: String?
    let tr_ios: String?
    let tr_hd: String?
    let tr_sd: String?
    let tr_mp4: String?
    let priority: String?
    let now_showing: String?
    let advance_ticket: String?
    let date_update: String?
    let show_buyticket: String?
    let trailer_cms_id: String?
    let trailer_ivx_key: String?
    
    private let title_en: String?
    private let title_th: String?
    private let synopsis_en: String?
    private let synopsis_th: String?

    var title: String {
        if let preferredLanguage = Locale.preferredLanguages.first {
            if preferredLanguage.hasPrefix("th") {
                return title_th ?? ""
            }
        }
        return title_en ?? ""
    }

    var synopsis: String {
        if let preferredLanguage = Locale.preferredLanguages.first {
            if preferredLanguage.hasPrefix("th") {
                return synopsis_th ?? ""
            }
        }
        return synopsis_en ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case id
        case movieCode
        case rating
        case rating_id
        case duration
        case release_date
        case sneak_date
        case director
        case actor
        case genre
        case poster_ori
        case poster_url
        case trailer
        case tr_ios
        case tr_hd
        case tr_sd
        case tr_mp4
        case priority
        case now_showing
        case advance_ticket
        case date_update
        case show_buyticket
        case trailer_cms_id
        case trailer_ivx_key
        case title_en
        case title_th
        case synopsis_en
        case synopsis_th
    }
}

struct MoviesResponse: Codable {
    let movies: [Movie]
}
