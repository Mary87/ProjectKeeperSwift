//
//  ProjectsManager.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ProjectsManagerProtocol {
    
    func loadProjects(onComplete: ([Project]?) -> ())

}


class ProjectsManager: BaseManager, ProjectsManagerProtocol {
    
    // MARK: Properties
    
    let projectsRepository = InstancesFabric.projectsRepository()
    
    
    
    // MARK: ProjectsManagerProtocol
    
    func loadProjects(onComplete: ([Project]?) -> ()) {
        return projectsRepository.loadProjects({ (projects) -> (Void) in
            dispatch_async(dispatch_get_main_queue(), {
                onComplete(projects)
            })
        })
    }
    


}
