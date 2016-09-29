//
//  Asset.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

enum AssetType: String {
    case image = "image"
    case movie = "movie"
    case pdfFile = "pdf"
    case unknown
}

class Asset: NSObject {
    
    // MARK: Properties
    
    let contentUrlString: String
    let assetType: AssetType
    
    
    
    // MARK: Initializers
    
    init?(parametersDictionary: Dictionary<String, AnyObject>) {
        let url = parametersDictionary["url"] as? String
        if url!.isEmpty {
            return nil
        }
        
        self.contentUrlString = url!
        if let type = parametersDictionary["type"] as? String, let associatedType = AssetType(rawValue: type) {
            self.assetType = associatedType
        }
        else {
            self.assetType = AssetType.unknown
        }
    }
}
