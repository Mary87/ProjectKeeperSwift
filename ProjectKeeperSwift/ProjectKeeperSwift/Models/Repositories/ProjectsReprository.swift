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
    
    // MARK: Properties
    
    static let sharedRepository = ProjectsReprository()
    
    
    
    // MARK: Public
    
    func loadProjects(onComplete: ([Project]) -> (Void)) {
        let projectsUrl = environment.projectsUrl
        webDataService.getDataFromUrl(projectsUrl) { (jsonData) -> (Void) in
            onComplete(self.extractProjectsFromData(jsonData))
        }
    }
    
    func loadImageForProject(project:Project, onComplete: (UIImage) -> (Void)) {
        let imageUrlString = project.thumbnailImageUrl
        webDataService.getDataFromUrl(imageUrlString) { (data) -> (Void) in
            onComplete(self.extractImageFromData(data))
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
    
    private func extractImageFromData(imageData: NSData?) -> UIImage {
        let image = UIImage(data:imageData!,scale:1.0)!
        return image
    }
    
    
    
}
