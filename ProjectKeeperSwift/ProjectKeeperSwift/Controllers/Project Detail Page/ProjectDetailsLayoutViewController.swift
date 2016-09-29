//
//  ProjectDetailsLayoutViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/23/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

protocol ProjectDetailsLayoutViewControllerDelegate {
    
    func loadImageForAsset(asset: Asset, onComplete:(UIImage) -> ())
    
}

class ProjectDetailsLayoutViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, SlideAssetCollectionViewCellDelegate, UICollectionViewDelegateFlowLayout, MovieAssetCollectionViewCellDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var supportedScreensLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var solutionTypesLabel: UILabel!
    @IBOutlet weak var technologiesLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var slideAssetsCollectionView: UICollectionView!
    @IBOutlet weak var movieAssetsCollectionView: UICollectionView!
    
    @IBOutlet weak var baseInformationView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var clientNameView: UIView!
    @IBOutlet weak var solutionTypesView: UIView!
    @IBOutlet weak var technologiesView: UIView!
    @IBOutlet weak var slidesView: UIView!
    @IBOutlet weak var projectNameView: UIView!
    @IBOutlet weak var projectThumbnailImageViewWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var movieAssetsView: UIView!
    
    var currentProject: Project!
    var imageAssets = [Asset]()
    var movieAssets = [Asset]()
    var pdfAssets = [Asset]()
    
    var layoutDelegate: ProjectDetailsLayoutViewControllerDelegate!
    var dummySlideAssetCell: SlideAssetCollectionViewCell!
    var dummyMovieAssetCell: MovieAssetCollectionViewCell!
    
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingOverlay()
        self.configureCollectionViews()
        self.setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: Public
    
    func updateWithProject(project: Project) -> () {
        currentProject = project
        
        for asset in project.assets {
            switch asset.assetType {
            case .image:
                imageAssets.append(asset)
            case .movie:
                movieAssets.append(asset)
            case .pdfFile:
                pdfAssets.append(asset)
            default: break
            }
        }
        
        updateWithProjectInfo()
        slideAssetsCollectionView.reloadData()
        movieAssetsCollectionView.reloadData()
        self.hideLoadingOverlay()
    }
    
    func updateWithProjectThumbnailImage(image: UIImage) -> () {
        self.projectImageView.image = image
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slideAssetsCollectionView {
            return imageAssets.count
        }
        else if collectionView == movieAssetsCollectionView {
            return movieAssets.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if collectionView == slideAssetsCollectionView {
            let asset = imageAssets[indexPath.item]
            cell = SlideAssetCollectionViewCell.assetCollectionViewCellWith(asset, delegate: self, indexPath: indexPath, collectionView: collectionView)
        }
        if collectionView == movieAssetsCollectionView {
            let asset = movieAssets[indexPath.item]
            cell = MovieAssetCollectionViewCell.movieAssetCollectionViewCellWith(asset, delegate: self, indexPath: indexPath, collectionView: collectionView)
        }

        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == movieAssetsCollectionView {
            let selectedAsset = movieAssets[indexPath.item]
            let playerVC = AVPlayerViewController.init()
            let saveUrlString = selectedAsset.contentUrlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let url = NSURL(string:  saveUrlString!)
            playerVC.player = AVPlayer(URL: url!)
            presentViewController(playerVC, animated: true, completion: { 
                playerVC.player?.play()
            })
        }
    }
    
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == slideAssetsCollectionView {
            return dummySlideAssetCell.frame.size
        }
        else if collectionView == movieAssetsCollectionView {
            return dummyMovieAssetCell.frame.size
        }
        else {
            return CGSize.zero
        }
    }
    
    
    
    // MARK: AssetCollectionViewCellDelegate
    
    func loadImageForAsset(asset: Asset, onComplete: (UIImage) -> ()) {
        layoutDelegate.loadImageForAsset(asset) { (image) in
            onComplete(image)
        }
    }
    
    
    
    // MARK: Private
    
    private func updateWithProjectInfo() {
        // Configure Project Name label
        if currentProject.projectName.isEmpty {
            projectNameView.hidden = true
        }
        projectNameLabel.text = currentProject.projectName
        
        // Configure Release Year label
        let releaseYearAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: releaseYearLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        let releaseYearAttrString = NSMutableAttributedString(string: "Release year ", attributes: releaseYearAttributes)
        if currentProject.releaseYear > 0 {
            releaseYearAttrString.appendAttributedString(NSAttributedString(string: String(currentProject.releaseYear)))
        }
        else {
            releaseYearAttrString.appendAttributedString(NSAttributedString(string: "-"))
        }
        releaseYearLabel.attributedText = releaseYearAttrString
        
        // Configure Supported Screens label
        if !currentProject.supportedScreens.isEmpty {
            let supportedScreensAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: supportedScreensLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
            
            let supportedScreensAttrString = NSMutableAttributedString(string: "Supported Screens: ", attributes: supportedScreensAttributes)
            let joinedSuppotredScreensAttrString = NSAttributedString(string: "\n - " + currentProject.supportedScreens.joinWithSeparator("\n - "))
            supportedScreensAttrString.appendAttributedString(joinedSuppotredScreensAttrString)
            supportedScreensLabel.attributedText = supportedScreensAttrString
        }
        else {
            supportedScreensLabel.text = ""
        }
        
        // Configure Project Description label
        
        if currentProject.projectDescription.isEmpty {
            descriptionView.hidden = true
        }
        else {
            descriptionLabel.text = currentProject.projectDescription
        }
        
        // Configure Client Name label

        if ((currentProject.client?.clientName) != nil) {
            let clientNameAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: clientNameLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
            
            let clientNameAttrString = NSMutableAttributedString(string: "Client: ", attributes: clientNameAttributes)
            clientNameAttrString.appendAttributedString(NSAttributedString(string: String(currentProject.client!.clientName!)))
            clientNameLabel.attributedText = clientNameAttrString
        }
        else {
            clientNameView.hidden = true
        }
        
        // Configure Solution Types label
        
        let solutionTypesAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: solutionTypesLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let solutionTypesAttrString = NSMutableAttributedString(string: "Solution Types: ", attributes: solutionTypesAttributes)
        let joinedTypesAttrString = NSAttributedString(string: currentProject.solutionTypes.joinWithSeparator(", "))
        
        solutionTypesAttrString.appendAttributedString(joinedTypesAttrString)
        solutionTypesLabel.attributedText = solutionTypesAttrString
        
        // Configure Technologies label
        
        let technologiesAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: technologiesLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let technologiesAttrString = NSMutableAttributedString(string: "Technologies: ", attributes: technologiesAttributes)
        let joinedTechnologiesAttrString = NSAttributedString(string: currentProject.technologies.joinWithSeparator(", "))
        
        technologiesAttrString.appendAttributedString(joinedTechnologiesAttrString)
        technologiesLabel.attributedText = technologiesAttrString
        
        if imageAssets.isEmpty {
            slidesView.hidden = true
        }
        if movieAssets.isEmpty {
            movieAssetsView.hidden = true
        }
    }

    private func configureCollectionViews() {
        let slideAssetCell = SlideAssetCollectionViewCell.cellNib();
        self.dummySlideAssetCell = slideAssetCell.instantiateWithOwner(nil, options: nil).first as! SlideAssetCollectionViewCell
        SlideAssetCollectionViewCell.registerInCollectionView(slideAssetsCollectionView)
        
        let movieAssetCell = MovieAssetCollectionViewCell.cellNib();
        self.dummyMovieAssetCell = movieAssetCell.instantiateWithOwner(nil, options: nil).first as! MovieAssetCollectionViewCell
        MovieAssetCollectionViewCell.registerInCollectionView(movieAssetsCollectionView)
    }
    
    private func setupAppearance() {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            projectThumbnailImageViewWidthLayoutConstraint.constant = 200
        default:
            projectThumbnailImageViewWidthLayoutConstraint.constant = 110
        }
    }
}
