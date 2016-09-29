//
//  ProjectDetailsViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/23/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: BaseViewController, ProjectDetailsLayoutViewControllerDelegate {
    
    private let layoutVCPresentationSegue = "layoutVCPresentationSegue"
    
    private var clientsManager = InstancesFabric.clientsManager()
    private var assetsManager = InstancesFabric.assetsManager()
    var layoutVC: ProjectDetailsLayoutViewController!
    var currentProject: Project!
    
    

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAdditionalDetailsForProject(self.currentProject) { (loadingFinished, project) in
            if loadingFinished {
                self.currentProject = project
                self.layoutVC.updateWithProject(project)
            }
        }
        loadThumbnailImageForProject(self.currentProject)
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
        }
     }

    
    
    // MARK: ProjectDetailsLayoutViewControllerDelegate
    
    func loadImageForAsset(asset: Asset, onComplete: (UIImage) -> ()) {
        webImageLoader.loadImageForAsset(asset) { (image) in
            onComplete(image)
        }
    }
    
 
 
    // MARK: Private
 
    private func loadAdditionalDetailsForProject(project: Project, withCompletion comeletion:(Bool, Project) -> ()) -> () {
        var clientsUpdateFinished = false
        var assetsUpdateFinished = false
        
        clientsManager.loadClientForProject(project) { (project) in
            dispatch_async(dispatch_get_main_queue(), {
                clientsUpdateFinished = true
                if clientsUpdateFinished && assetsUpdateFinished {
                    comeletion(true, project)
                }
            })
        }
        
        assetsManager.loadAssetsForProject(project) { (project) in
            dispatch_async(dispatch_get_main_queue(), {
                assetsUpdateFinished = true
                if clientsUpdateFinished && assetsUpdateFinished {
                    comeletion(true, project)
                }
            })
        }
    }
    
    private func loadThumbnailImageForProject(project: Project) -> () {
        webImageLoader.loadThumbnailImageForProject(project) { (image) in
            self.layoutVC.updateWithProjectThumbnailImage(image)
        }
    }

}
