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

    private var layoutVC: ProjectsLayoutViewController!
    private var projects = [Project]()
    

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == layoutVCPresentationSegue {
            self.layoutVC = segue.destinationViewController as! ProjectsLayoutViewController
            self.layoutVC.layoutDelegate = self
        }
    }
}

