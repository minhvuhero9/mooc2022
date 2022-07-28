//
//  ListMovieViewModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 15/07/2022.
//

import UIKit

class ListMovieViewModel: NSObject {
    var model: ListMovieModelProtocol?
    var movies: [Movie] = []
    
    func getAllMovies() {
        model?.fetchAllMovies()
        movies = model?.movies ?? []
    }
    
    func fetchMoviesSever() {
        model?.fetchMovieFromSever()
    }
    
    func logURL() {
        model?.logURL()
    }
    
}
