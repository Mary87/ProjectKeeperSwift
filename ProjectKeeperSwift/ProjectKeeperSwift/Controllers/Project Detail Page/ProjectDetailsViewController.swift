//
//  ProjectDetailsViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/23/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController, ProjectDetailsLayoutViewControllerDelegate {
    
    private let layoutVCPresentationSegue = "layoutVCPresentationSegue"
    private var projectsManager = ProjectsManager.sharedManager
    var layoutVC: ProjectDetailsLayoutViewController!
    var currentProject: Project!
    
    

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAdditionalDetailsForProject(self.currentProject)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: Navigation

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         if segue.identifier == layoutVCPresentationSegue {
            self.layoutVC = segue.destinationViewController as! ProjectDetailsLayoutViewController
            self.layoutVC.layoutDelegate = self
            self.layoutVC.currentProject = self.currentProject
        }
     }

 
 
    // MARK: Private
 
    private func loadAdditionalDetailsForProject(project: Project) -> () {
        projectsManager.updateProjectWithClient(project) { (project) in
            dispatch_async(dispatch_get_main_queue(), {
                self.layoutVC.updateWithProject(project)
            })
        }
        
        projectsManager.updateProjectWithClient(project) { (project) in
            dispatch_async(dispatch_get_main_queue(), {
                self.layoutVC.updateWithProject(project)
            })
        }
    }

}
