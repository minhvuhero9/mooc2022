//
//  ListViewController.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 11/07/2022.
//

import UIKit

class ListViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: Properties
    private let cellSpacing: CGFloat = 1
    private var numberColumn: CGFloat = 3
    private let heightTitle: CGFloat = 73
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: Private
private extension ListViewController {
    func configureView() {
        configureNavigationController()
        configureCollectionView()
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
    }
}

// MARK: Action
private extension ListViewController {
    @objc
    func gridAction(_ sender: UIBarButtonItem) {
        if numberColumn > 1 {
            sender.image = UIImage(systemName: "rectangle.grid.1x2")
            numberColumn = 1
        } else {
            sender.image = UIImage(systemName: "square.grid.2x2")
            numberColumn = 3
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: CollectionView DataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configureCell(image: UIImage(named: "dog")!, title: "Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label")
        return cell
    }
}

// MARK: CollectionView Delegate
extension ListViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let emptySpace = layout.sectionInset.left + layout.sectionInset.right + (numberColumn * cellSpacing - 1)
        let cellSize = (view.frame.size.width - emptySpace) / numberColumn
      return CGSize(width: cellSize, height: cellSize + heightTitle)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return cellSpacing
    }
}
