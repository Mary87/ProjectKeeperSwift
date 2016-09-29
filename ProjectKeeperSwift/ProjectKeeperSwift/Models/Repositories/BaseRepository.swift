//
//  BaseRepository.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class BaseRepository: NSObject {
    
    // MARK: Properties
    
    let environment = Environment.sharedInstance
    let webDataService = InstancesFabric.webDataService()

}
