//
//  ListMovieViewModel.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 15/07/2022.
//

import UIKit

class ListMovieViewModel: NSObject {
    // MARK: - Properties
    var listMovies = [MovieModel]()
    var getListMoviesSuccess: () -> Void = { }
    var getListMoviesFailure: (String) -> Void = { _ in }

}

extension ListMovieViewModel {
    func getListMovies() {
        NetworkManager.shared.getListMovie { [weak self] result in
            switch result {
            case.success(let data):
                if let listMovies = data.results {
                    self?.listMovies = listMovies
                    self?.getListMoviesSuccess()
                }
            case.failure(let error):
                self?.getListMoviesFailure(error.localizedDescription)
            }
        }
    }
}
