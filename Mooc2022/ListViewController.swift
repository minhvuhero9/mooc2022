//
//  ListViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit
import Kingfisher

class ListViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: Properties
    let defaultHeightCell: CGFloat = 200
    
    let viewModel = ListMovieViewModel()

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.getListMovies()
        viewModel.getListMoviesSuccess = {
            print("success")
            print("\(self.viewModel.listMovies)")
            self.collectionView.reloadData()
        }
    }
}

// MARK: Private
private extension ListViewController {
    func configureView() {
        configureNavigationController()
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func configureNavigationController() {
        title = "Movie List"
    }
    
    func configureCollectionView() {
        let movieNib = UINib(nibName: "MovieCell", bundle: nil)
        collectionView.register(movieNib, forCellWithReuseIdentifier: MovieCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        if let layout = collectionView?.collectionViewLayout as? CustomCollectionViewLayout {
          layout.delegate = self
        }
    }
}

// MARK: Action
private extension ListViewController {
    
}

// MARK: CollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.listMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configureCell(model: self.viewModel.listMovies[indexPath.row])
        return cell
    }
}

// MARK: CollectionView Delegate
extension ListViewController: UICollectionViewDelegate {
    
}

// MARK: CustomCollectionViewLayoutDelegate
extension ListViewController: CustomCollectionViewLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let model = self.viewModel.listMovies[indexPath.row];
        guard let image = model.posterPath else {
            return 0
        }
        let imageView = UIImageView()
        imageView.kf.setImage(with: DataManager.getImageURL(image))
        let heightImage = imageView.image?.size.height ?? defaultHeightCell
        return heightImage
  }
}
