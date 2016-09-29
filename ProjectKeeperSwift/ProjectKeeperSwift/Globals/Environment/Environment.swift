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
    var projectsUrl: String {
        get {
            return (environmentDictionary["apiProjectsList"] as? String)!
        }
    }
    var clientsUrl: String {
        get {
            return (environmentDictionary["apiClients"] as? String)!
        }
    }
    var relatedAssetsUrl: String {
        get {
            return (environmentDictionary["apiProjectAssets"] as? String)!
        }
    }
    var environmentDictionary: [String : AnyObject]
    
    
    
    // MARK: Initializers
    
    private override init() {
        let bundle = NSBundle.mainBundle()
        let plistPath = bundle.pathForResource("Environments", ofType: "plist")
        let environmentsDict = NSDictionary.init(contentsOfFile: plistPath!)
        environmentDictionary = environmentsDict as! [String : AnyObject]
    }
    
    
}
