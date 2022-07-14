//
//  HomeViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit

class HomeViewController: BaseViewController {
    let viewModel = ListMovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        viewModel.getListMovies()
        viewModel.getListMoviesSuccess = {
            print("success")
            print("\(self.viewModel.listMovies)")
        }
    }
}
