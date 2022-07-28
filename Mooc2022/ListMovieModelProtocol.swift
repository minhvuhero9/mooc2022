//
//  IMovieViewModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//

protocol ListMovieModelProtocol {
    var movies: [Movie] { get set }
    var repo: MovieRepositoryProtocol { get set }
    
    func fetchAllMovies()
    func saveMovie(movie: Movie)
    func fetchMovieFromSever()
    func logURL()
}

