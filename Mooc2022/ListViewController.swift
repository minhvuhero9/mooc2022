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
    
    /// Helper Animation
    var lastContentOffset: CGFloat = 0
    var yCellTransform: CGFloat = 0
    
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
    
    // MARK: Animation cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        /// 3DMakeScale Animation
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1.0)
        UIView.animate(withDuration: 1.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
        
        /// Affine Animation
        cell.transform = CGAffineTransform(translationX: 0, y: yCellTransform)
        UIView.animate(
            withDuration: 1,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                
            })
        
        /// Fade Animation
        cell.alpha = 0
        UIView.animate(withDuration: 1.5, delay: 0.1 * Double(indexPath.row), animations: {
            cell.alpha = 1
        })
    }
}

// MARK: UIScrollViewDelegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }

    /// while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            /// did move up
            yCellTransform = UIScreen.main.bounds.height / 2
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            /// did move down
            if lastContentOffset == 0 {
                yCellTransform = UIScreen.main.bounds.height / 2
            } else {
                yCellTransform = -UIScreen.main.bounds.height / 2
            }
        } else {
            /// didn't move
        }
    }
}
