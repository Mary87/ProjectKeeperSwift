//
//  MovieAssetCollectionViewCell.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/29/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

let movieAssetCollectionViewCellReuseId = "movieAssetCollectionViewCellReuseId"

protocol MovieAssetCollectionViewCellDelegate {
    
    
    
}

class MovieAssetCollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    
    @IBOutlet weak var movieThumbnailImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    var delegate: MovieAssetCollectionViewCellDelegate?
    var currentAsset: Asset?
    
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        currentAsset = nil
        movieTitleLabel.text = nil
    }
    
    
    
    // MARK: Public
    
    class func cellNib() -> UINib {
        return UINib.init(nibName: String(self), bundle: nil)
    }
    
    class func registerInCollectionView(collectionView: UICollectionView) -> () {
        let cellNib = MovieAssetCollectionViewCell.cellNib()
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: movieAssetCollectionViewCellReuseId)
    }
    
    class func movieAssetCollectionViewCellWith(asset: Asset, delegate:MovieAssetCollectionViewCellDelegate, indexPath: NSIndexPath, collectionView: UICollectionView) -> (MovieAssetCollectionViewCell) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(movieAssetCollectionViewCellReuseId, forIndexPath: indexPath) as! MovieAssetCollectionViewCell
        cell.delegate = delegate
        cell.currentAsset = asset
        cell.movieTitleLabel.text = "Movie " + String(indexPath.item + 1)
        return cell
    }
    
}
