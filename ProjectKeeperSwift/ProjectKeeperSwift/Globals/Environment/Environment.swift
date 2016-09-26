//
//  Environment.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class Environment: NSObject {
    
    // MARK: Properties
    
    static let sharedInstance = Environment ()
    let projectsUrl = "http://91.250.82.77:8081/3ssdemo/prj/json/projects.php"
    let relatedAssetsUrl = "http://91.250.82.77:8081/3ssdemo/prj/json/galleryAssets.php?projectId={ID}"
    let clientsUrl = "http://91.250.82.77:8081/3ssdemo/prj/json/clients.php"
    
    
    
    // MARK: Initializers
    
    private override init() {
        
    }
    
}
