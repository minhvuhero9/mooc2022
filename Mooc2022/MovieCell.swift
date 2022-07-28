//
//  MovieCell.swift
//  Mooc2022
//
//  Created by Nguyen Huu Hung on 7/12/22.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    // MARK: Properties
    static let identifier: String = "MovieCell"
    let defaultHeightCell: CGFloat = 200

    // MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
    }
}

// MARK: Configure
extension MovieCell {
    func configureUI() {
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
    
    func configureCell(movie: Movie) {
        imageView.kf.setImage(with: DataManager.getImageURL(movie.posterPath))
        titleLabel.text = movie.title
    }
}
