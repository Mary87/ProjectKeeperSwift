//
//  ProjectsViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class ProjectsViewController: BaseViewController, ProjectsLayoutViewControllerDelegate {
    
    // MARK: Properties
    
    private let layoutVCPresentationSegue = "layoutVCPresentationSegue"
    private let projectsManager = InstancesFabric.projectsManager()

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
    
    func loadThumbnailImageForProject(project: Project, onComplete: (UIImage) -> (Void)) {
        webImageLoader.loadThumbnailImageForProject(project) { (image) in
            onComplete(image)
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
                self.layoutVC.updateWithProjects(projects!)
            }
        }
    }
    
    private func setupAppearance() {
        view.backgroundColor = UIColor.blackColor()
        navigationItem.title = "Projects List"
    }

}
