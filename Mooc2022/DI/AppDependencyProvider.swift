//
//  AppDependencyProvider.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//

import RealmSwift
struct AppDependencyProvider {
    static var listMovies = ListMovie()
    static var realm = try! Realm()

    static var dataSource: DataSourceProtocol {
        return RealmLocalDataSource(realm: realm)
    }

    static var repo: MovieRepositoryProtocol {
        return MovieRepository(dataSource: self.dataSource)
    }
    
    static var listMovieModel: ListMovieModelProtocol {
        return ListMovieModel(movies: self.listMovies.results, repo: self.repo)
    }
    
    static var mainTabbarController: MainViewController {
        let vc = MainViewController()
         return vc
    }
    
    static var homeViewController: HomeViewController {
        let vc = HomeViewController()
        return vc
    }
    
    static var listViewController: ListViewController {
        let vc = ListViewController()
        vc.viewModel.model = self.listMovieModel
        return vc
    }
    
    static var loginViewController: LoginViewController {
        let vc = LoginViewController()
        //vc.todoViewModel = self.todoViewModel
        return vc
    }
}