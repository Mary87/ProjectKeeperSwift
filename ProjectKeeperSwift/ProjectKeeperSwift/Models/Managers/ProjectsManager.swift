//
//  ProjectsManager.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit
import Objection

protocol ProjectsManagerProtocol {
    
    func loadProjects(onComplete: ([Project]?) -> ())
    func updateProjectWithAssets(project: Project, onComplete: (Project) -> ())
    func updateProjectWithClient(project: Project, onComplete: (Project) -> ())
    func loadImageForProject(project:Project, onComplete: (UIImage) -> (Void))

}

class ProjectsManager: NSObject, ProjectsManagerProtocol {
    
    static let sharedManager = ProjectsManager()
    
    // MARK: Properties
    
    let projectsRepository = ProjectsReprository()
    let assetsRepository = AssetsRepository()
    let clientsRepository = ClientsRepository()
    
    
    
    // MARK: Initializers
    
    // MARK: Public
    
    func loadProjects(onComplete: ([Project]?) -> ()) {
        return projectsRepository.loadProjects({ (projects) -> (Void) in
            onComplete(projects)
        })
    }
    
    func updateProjectWithAssets(project: Project, onComplete: (Project) -> ()) {
        assetsRepository.loadAssetsForProjectWithId(project.projectId, onComplete: { (assets) -> (Void) in
            project.assets = assets
            onComplete(project)
        })
    }
    
    func updateProjectWithClient(project: Project, onComplete: (Project) -> ()) {
        clientsRepository.loadClients({ (clients) -> (Void) in
            for client in clients {
                if client.clientId == project.clientId {
                    project.client =  client
                    onComplete(project)
                }
            }
        })
    }
    
    func loadImageForProject(project:Project, onComplete: (UIImage) -> (Void)) {
        return projectsRepository.loadImageForProject(project, onComplete: { (image) -> (Void) in
            onComplete(image)
        })
    }
    
    
}
