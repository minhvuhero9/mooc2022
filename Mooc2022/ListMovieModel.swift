//
//  ListMovieModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 15/07/2022.
//

import UIKit

struct ListMovieModel {
    let id: Int?
    let totalResult: Int?
    let results: [MovieModel]?
}

extension ListMovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case totalResult = "total_results"
        case results
    }
}

struct MovieModel {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let mediaType: String
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    
}
extension MovieModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
