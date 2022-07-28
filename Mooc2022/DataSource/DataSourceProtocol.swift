//
//  IDataSource.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//

import Foundation
protocol DataSourceProtocol {
    func saveMovie(movie: Movie)
    func fetchAllMovies() -> [Movie]
    func saveListMovie(movies: [Movie])
    func getDatabaseURL() -> URL?
}
