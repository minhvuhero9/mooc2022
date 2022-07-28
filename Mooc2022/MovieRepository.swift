//
//  MovieRepository.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//

import Foundation

class MovieRepository: MovieRepositoryProtocol {
    var dataSource: DataSourceProtocol
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func saveMovie(movie: Movie) {
        dataSource.saveMovie(movie: movie)
    }
    
    func fetchAllMovies() -> [Movie] {
        dataSource.fetchAllMovies()
    }
    
    func getDatabaseURL() -> URL? {
        return dataSource.getDatabaseURL()
    }

}
