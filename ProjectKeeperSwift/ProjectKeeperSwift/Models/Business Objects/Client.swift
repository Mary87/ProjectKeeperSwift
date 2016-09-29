//
//  Client.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class Client: NSObject {
    
    // MARK: Properties
    
    let clientId: String
    let clientName: String
    let clientDescription: String
    let webSiteUrl: String
    

    
    // MARK: Initializers
    
    init?(parametersDictionary: Dictionary<String, AnyObject>) {
        let id = parametersDictionary["id"] as? Int
        if id == nil {
            return nil
        }
        
        self.clientId = String(id)
        self.clientName = parametersDictionary["name"] as? String ?? ""
        self.clientDescription = parametersDictionary["description"] as? String ?? ""
        self.webSiteUrl = parametersDictionary["url"] as? String ?? ""
    }
}
