//
//  Project.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class Project: NSObject {
    
    // MARK: lets & vars
    
    let projectId: String
    let projectName: String
    let releaseYear: Int
    let projectDescription: String
    let thumbnailImageUrlString: String
    let clientId: String
    let solutionTypes: [String]
    let technologies: [String]
    let supportedScreens: [String]
    
    var assets = [Asset]()
    var client:Client?
    
    
    
    // MARK: lifecycle
    
    init?(parametersDictionary: Dictionary<String, AnyObject>) {
        let id = parametersDictionary["id"] as? Int
        if (id == nil) {
            return nil
        }
        
        projectId = String(id!)
        projectName = parametersDictionary["name"] as? String ?? ""
        releaseYear = parametersDictionary["year"] as? Int ?? 0
        projectDescription = parametersDictionary["description"] as? String ?? ""
        clientId = String(parametersDictionary["clientId"] as? Int)
        
        let imageDictionary = parametersDictionary["image"] as? Dictionary<String, AnyObject>
        thumbnailImageUrlString = imageDictionary!["url"] as? String ?? ""
        
        solutionTypes = parametersDictionary["solutionTypes"] as? Array<String> ?? []
        supportedScreens = parametersDictionary["supportedScreens"] as? Array<String> ?? []
        technologies = parametersDictionary["technologies"] as? Array<String> ?? []
    }
    
}
