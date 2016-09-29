//
//  WebImageLoader.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/28/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol WebImageLoaderProtocol {
    
    func loadThumbnailImageForProject(project: Project, onComplete: (UIImage) -> ()) -> ()
    func loadImageForAsset(asset: Asset, onComlete: (UIImage) -> ()) -> ()
    
}



class WebImageLoader: NSObject, WebImageLoaderProtocol {
    
    // MARK: Properties
    
    let webDataService = InstancesFabric.webDataService()
    var cache = NSCache()
    
    
    
    // MARK: WebImageLoaderProtocol
    
    func loadThumbnailImageForProject(project: Project, onComplete: (UIImage) -> ()) -> () {
        loadImageForUrlString(project.thumbnailImageUrlString) { (image) in
            onComplete(image)
        }
    }
    
    func loadImageForAsset(asset: Asset, onComlete: (UIImage) -> ()) -> () {
        loadImageForUrlString(asset.contentUrlString) { (image) in
            onComlete(image)
        }
    }
    
    
    
    // MARK: Private
    
    private func loadImageForUrlString(urlString: String, onComplete: (UIImage) -> ()) -> () {
        if (self.cache.objectForKey(urlString) != nil) {
            onComplete((self.cache.objectForKey(urlString) as? UIImage)!)
        }
        else {
            webDataService.getDataFromUrl(urlString) { (data) -> (Void) in
                dispatch_async(dispatch_get_main_queue(), {
                    let image = self.extractImageFromData(data)
                    self.cache.setObject(image, forKey: urlString)
                    onComplete(image)
                })
            }
        }
    }
    
    private func extractImageFromData(imageData: NSData?) -> UIImage {
        var image = UIImage()
        image = UIImage(data:imageData!,scale:1.0)!
        return image
    }
}
