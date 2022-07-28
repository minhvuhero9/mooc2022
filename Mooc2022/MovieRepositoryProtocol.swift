//
//  IMovieRepository.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//
import Foundation

protocol MovieRepositoryProtocol {
    var dataSource: DataSourceProtocol { get set }

    func saveMovie(movie: Movie)
    func fetchAllMovies() -> [Movie]
    func getDatabaseURL() -> URL?
}
