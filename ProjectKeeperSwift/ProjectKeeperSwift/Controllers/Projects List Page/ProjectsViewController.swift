//
//  ProjectsViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, ProjectsLayoutViewControllerDelegate {
    
    // MARK: Properties
    
    private let layoutVCPresentationSegue = "layoutVCPresentationSegue"
    private let projectsManager = ProjectsManager.sharedManager

    private var layoutVC: ProjectsLayoutViewController!
    private var projects = [Project]()
    

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateWithProjects()
        setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == layoutVCPresentationSegue {
            self.layoutVC = segue.destinationViewController as! ProjectsLayoutViewController
            self.layoutVC.layoutDelegate = self
        }
    }
    
    
    
    // MARK: ProjectsLayoutViewControllerDelegate
    
    func loadImageForProject(project: Project, onComplete: (UIImage) -> (Void)) {
        projectsManager.loadImageForProject(project) { (image) -> (Void) in
            dispatch_async(dispatch_get_main_queue(), {
                onComplete(image)
            })
        }
    }
    
    func tableViewDidSelectProject(project: Project) {
        let detailsStoryboard = UIStoryboard.init(name: "ProjectDetails", bundle: nil)
        let detailsVC = detailsStoryboard.instantiateViewControllerWithIdentifier("ProjectDetailsViewController") as! ProjectDetailsViewController
        detailsVC.currentProject = project
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    
    // MARK: Private
    
    private func updateWithProjects() {
        projectsManager.loadProjects { (projects) in
            if projects != nil {
                self.projects = projects!
                dispatch_async(dispatch_get_main_queue(), {
                    self.layoutVC.updateWith(projects!)
                })
            }
        }
    }
    
    private func setupAppearance() {
        self.view.backgroundColor = UIColor.blackColor()
    }
    
}

