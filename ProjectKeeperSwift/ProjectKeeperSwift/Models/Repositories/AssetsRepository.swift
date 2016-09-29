//
//  AssetsRepository.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol AssetsRepositoryProtocol {
    
    func loadAssetsForProjectWithId(projectId: String, onComplete: ([Asset]) -> (Void))
    
}

class AssetsRepository: BaseRepository, AssetsRepositoryProtocol {

    // MARK: AssetsRepositoryProtocol
    
    func loadAssetsForProjectWithId(projectId: String, onComplete: ([Asset]) -> (Void))  {
        let urlString = self.environment.relatedAssetsUrl.stringByReplacingOccurrencesOfString("{ID}", withString: projectId)
        webDataService.getDataFromUrl(urlString) { (jsonData) -> (Void) in
            onComplete(self.extractAssetsFromData(jsonData))
        }
    }
    
    
    
    // MARK: Private
    
    private func extractAssetsFromData(jsonData: NSData?) -> [Asset] {
        var assetsArray = [Asset]()
        do {
            let assetsDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:.AllowFragments) as? [String: [AnyObject]]
            if let assets = assetsDict!["assets"] {
                for asset in assets {
                    if let newAsset = Asset.init(parametersDictionary: asset as! Dictionary<String, AnyObject>) {
                        assetsArray.append(newAsset)
                    }
                }
            }
        }
        catch {
            print(String(self) + ": Error \(error) occured when extracting assets from JSON")
        }
        
        return assetsArray
    }
}
