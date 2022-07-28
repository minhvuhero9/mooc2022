//
//  MovieEntity.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//

import RealmSwift

class Movie: Object, Codable {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var mediaType: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var title: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Movie {
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


class ListMovie: Codable {
    var adult: Bool = false
    var id: Int = 0
    var totalResult: Int = 0
    var results: [Movie] = [Movie]()
}

extension ListMovie {
        enum CodingKeys: String, CodingKey {
            case id
            case totalResult = "total_results"
            case results
        }
}
