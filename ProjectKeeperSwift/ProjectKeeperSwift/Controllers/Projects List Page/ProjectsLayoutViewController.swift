//
//  ProjectsLayoutViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ProjectsLayoutViewControllerDelegate: class {
    
    func loadThumbnailImageForProject(project: Project, onComplete:(UIImage) -> (Void))
    func tableViewDidSelectProject(project: Project) -> ()
    
}



class ProjectsLayoutViewController: UITableViewController, ProjectTableViewCellDelegate {
    
    // MARK: Properties
    
    private var dummyCell = ProjectTableViewCell()
    private var projects = [Project]()
    
    weak var layoutDelegate: ProjectsLayoutViewControllerDelegate!
   
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        if !projects.isEmpty {
            refreshWithProjects(projects)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: Public
    
    func updateWithProjects(projects: [Project]) -> () {
        self.projects = projects
        
        guard isViewLoaded() else { return }
        refreshWithProjects(projects)
    }
    
    
    
    // MARK: ProgramTableViewCellDelegate
    
    func loadThumbnailImageForProject(project: Project, onComplete: (UIImage) -> ()) {
        self.layoutDelegate.loadThumbnailImageForProject(project) { (image) -> (Void) in
            onComplete(image)
        }
    }
    
    
    
    // MARK: Private
    
    private func configureTableView() {
        let tableViewCell = ProjectTableViewCell.cellNib();
        self.dummyCell = tableViewCell.instantiateWithOwner(nil, options: nil).first as! ProjectTableViewCell
        ProjectTableViewCell.registerInTableView(tableView)

    }
    
    private func refreshWithProjects(projects: [Project]) {
        tableView.reloadData()
    }
}



extension ProjectsLayoutViewController { // UITableViewDataSource & UITableViewDelegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let project = projects[indexPath.row]
        let cell = ProjectTableViewCell.projectTableViewCellWith(project, delegate: self, indexPath: indexPath, tableView: tableView)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return dummyCell.frame.height
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedProject = projects[indexPath.row]
        layoutDelegate.tableViewDidSelectProject(selectedProject)
    }
}
