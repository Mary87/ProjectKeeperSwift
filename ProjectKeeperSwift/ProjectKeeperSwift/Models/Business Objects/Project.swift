//
//  Project.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class Project: NSObject {
    
    // MARK: Properties
    
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
    
    
    
    // MARK: Initializers
    
    init?(parametersDictionary: Dictionary<String, AnyObject>) {
        let id = parametersDictionary["id"] as? Int
        if (id == nil) {
            return nil
        }
        
        self.projectId = String(id!)
        self.projectName = parametersDictionary["name"] as? String ?? ""
        self.releaseYear = parametersDictionary["year"] as? Int ?? 0
        self.projectDescription = parametersDictionary["description"] as? String ?? ""
        self.clientId = String(parametersDictionary["clientId"] as? Int)
        
        let imageDictionary = parametersDictionary["image"] as? Dictionary<String, AnyObject>
        self.thumbnailImageUrlString = imageDictionary!["url"] as? String ?? ""
        
        self.solutionTypes = parametersDictionary["solutionTypes"] as? Array<String> ?? []
        self.supportedScreens = parametersDictionary["supportedScreens"] as? Array<String> ?? []
        self.technologies = parametersDictionary["technologies"] as? Array<String> ?? []
    }
    
}
