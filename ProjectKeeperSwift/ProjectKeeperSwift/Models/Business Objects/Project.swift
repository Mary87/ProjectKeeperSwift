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
    let projectName: String?
    let releaseYear: Int?
    let projectDescription: String?
    let thumbnailImageUrl: String?
    let clientId: Int?
    let solutionTypes: [String]?
    let technologies: [String]?
    let supportedScreens: [String]?
    

    
    // MARK: Initializers
    
    init?(parametersDictionary: Dictionary<String, AnyObject>) {
        guard let id = parametersDictionary["id"] as? String
            else {
                return nil
        }
        
        if id.isEmpty {
            return nil
        }
        
        self.projectId = id
        self.projectName = parametersDictionary["name"] as? String
        self.releaseYear = parametersDictionary["year"] as? Int
        self.projectDescription = parametersDictionary["description"] as? String
        self.clientId = parametersDictionary["clientId"] as? Int
        
        let imageDictionary = parametersDictionary["image"] as? Dictionary<String, AnyObject>
        self.thumbnailImageUrl = (imageDictionary!["url"] as? String)
        
        self.solutionTypes = parametersDictionary["solutionTypes"] as? Array<String>
        self.supportedScreens = parametersDictionary["supportedScreens"] as? Array<String>
        self.technologies = parametersDictionary["technologies"] as? Array<String>
        
    }
    
}
