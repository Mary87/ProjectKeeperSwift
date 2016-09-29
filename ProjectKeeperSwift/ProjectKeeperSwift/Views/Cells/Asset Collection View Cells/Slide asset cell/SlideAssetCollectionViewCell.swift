//
//  SlideAssetCollectionViewCell.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/27/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

let slideAssetCollectionViewCellReuseId = "slideAssetCollectionViewCellReuseId"

protocol SlideAssetCollectionViewCellDelegate: class {
    
    func loadImageForAsset(asset: Asset, onComplete:(UIImage) -> ())

}

class SlideAssetCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties

    weak var delegate: SlideAssetCollectionViewCellDelegate?
    private(set) var currentAsset: Asset?
    
    @IBOutlet private weak var assetThumbnailImageView: UIImageView!
    
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        currentAsset = nil
        assetThumbnailImageView.image = UIImage.init(named: "placeholder-image")
    }
    
    
    
    // MARK: Public
    
    class func cellNib() -> UINib {
        return UINib.init(nibName: String(self), bundle: nil)
    }
    
    class func registerInCollectionView(collectionView: UICollectionView) -> () {
        let cellNib = SlideAssetCollectionViewCell.cellNib()
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: slideAssetCollectionViewCellReuseId)
    }
    
    class func assetCollectionViewCellWith(asset: Asset, delegate:SlideAssetCollectionViewCellDelegate, indexPath: NSIndexPath, collectionView: UICollectionView) -> (SlideAssetCollectionViewCell) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(slideAssetCollectionViewCellReuseId, forIndexPath: indexPath) as! SlideAssetCollectionViewCell
        cell.delegate = delegate
        cell.updateWithAsset(asset)
        return cell
    }
    
    
    
    // MARK: Private
    
    private func updateWithAsset(asset: Asset) -> () {
        currentAsset = asset
        if asset.assetType == .image {
            delegate?.loadImageForAsset(asset, onComplete: { (image) in
                if asset == self.currentAsset {
                    self.assetThumbnailImageView.image = image
                }
            })
        }
    }

}
