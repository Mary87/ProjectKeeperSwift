//
//  AssetsManager.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/27/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol AssetsManagerProtocol {
    
    func loadAssetsForProject(project: Project, onComplete: (Project) -> ())
}

class AssetsManager: BaseManager, AssetsManagerProtocol {
    
    // MARK: Properties
    
    let assetsRepository = InstancesFabric.assetsRepository()
    
    
    
    // MARK: AssetsManagerProtocol
    
    func loadAssetsForProject(project: Project, onComplete: (Project) -> ()) {
        assetsRepository.loadAssetsForProjectWithId(project.projectId, onComplete: { (assets) -> (Void) in
            project.assets = assets
            onComplete(project)
        })
    }

}
