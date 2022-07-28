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
    private var numberColumns: CGFloat = 2
    private let cellSpacing: CGFloat = 8
    private let heightTitle: CGFloat = 73
    
    var viewModel = ListMovieViewModel()
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchMoviesSever()
        viewModel.getAllMovies()
        viewModel.logURL()
        self.collectionView.reloadData()
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
        let gridButton = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(gridAction(_:)))
        gridButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = gridButton
    }
    
    func configureCollectionView() {
        let movieNib = UINib(nibName: "MovieCell", bundle: nil)
        collectionView.register(movieNib, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCollectionViewLayout() {
    }
}

// MARK: Action
private extension ListViewController {
    @objc
    func gridAction(_ sender: UIBarButtonItem) {
        if numberColumns > 1 {
            sender.image = UIImage(systemName: "rectangle.grid.1x2")
            numberColumns = 1
        } else {
            sender.image = UIImage(systemName: "square.grid.2x2")
            numberColumns = 2
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

// MARK: CollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configureCell(movie: self.viewModel.movies[indexPath.row])
        return cell
    }
}

// MARK: CollectionView Delegate
extension ListViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let emptySpace = layout.sectionInset.left + layout.sectionInset.right + (numberColumns * cellSpacing - 1)
        let cellSize = (view.frame.size.width - emptySpace) / numberColumns
        return CGSize(width: cellSize, height: cellSize + heightTitle)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}
