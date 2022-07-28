//
//  RealmLocalDataSource.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 27/07/2022.
//
import RealmSwift

final class RealmLocalDataSource: DataSourceProtocol {

    fileprivate let realm: Realm!
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func saveMovie(movie: Movie) {
        do {
            try realm.write({
                realm.add(movie, update: .all)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllMovies() -> [Movie] {
        return Array(realm.objects(Movie.self))
    }
    
    func saveListMovie(movies: [Movie]) {
        let movies = movies
        do {
            try realm.write({
                realm.add(movies, update: .all)
            })
        } catch {
            print(error.localizedDescription)
        }
    }

    func getDatabaseURL() -> URL? {
        return realm.configuration.fileURL
    }

    
}
