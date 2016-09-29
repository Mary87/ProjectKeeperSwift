//
//  ProjectsReprository.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ProjectsRepositoryProtocol {
    
    func loadProjects(onComplete: ([Project]) -> (Void))
    
}

class ProjectsReprository: BaseRepository, ProjectsRepositoryProtocol {
    
    // MARK: ProjectsRepositoryProtocol
    
    func loadProjects(onComplete: ([Project]) -> (Void)) {
        let projectsUrl = environment.projectsUrl
        webDataService.getDataFromUrl(projectsUrl) { (jsonData) -> (Void) in
            onComplete(self.extractProjectsFromData(jsonData))
        }
    }
    
    
    
    // MARK: Private
    
    private func extractProjectsFromData(jsonData: NSData?) -> [Project] {
        var projectsArray = [Project]()
        do {
            let projectsDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:.AllowFragments) as? [String: [AnyObject]]
            if let projects = projectsDict!["projects"] {
                for project in projects {
                    if let newProject = Project.init(parametersDictionary: project as! Dictionary<String, AnyObject>) {
                        projectsArray.append(newProject)
                    }
                }
            }
        }
        catch {
            print(String(self) + ": Error \(error) occured when extracting projects from JSON.")
        }
        
        return projectsArray
    }
    
}
