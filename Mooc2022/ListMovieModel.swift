//
//  ListMovieModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 15/07/2022.
//

import UIKit

class ListMovieModel: ListMovieModelProtocol {
    var movies: [Movie]
    
    var repo: MovieRepositoryProtocol
    
    init(movies: [Movie], repo: MovieRepositoryProtocol) {
        self.movies = movies
        self.repo = repo
    }
    
    func fetchAllMovies() {
        self.movies = repo.fetchAllMovies()
    }
    
    func saveMovie(movie: Movie) {
        repo.saveMovie(movie: movie)
    }
    
    func logURL() {
        print("REALM URL \(repo.getDatabaseURL())")
    }
    
    func fetchMovieFromSever() {
        NetworkManager.shared.getListMovie { result in
            switch result {
            case.success(let data):
                let movies = data.results
                for item in movies {
                    self.saveMovie(movie: item)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

