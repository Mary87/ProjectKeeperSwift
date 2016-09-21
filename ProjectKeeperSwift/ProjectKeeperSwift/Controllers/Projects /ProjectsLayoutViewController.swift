//
//  ProjectsLayoutViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ProjectsLayoutViewControllerDelegate {
    
}



class ProjectsLayoutViewController: UITableViewController {
    
    // MARK: Properties
    
    private let dummyCell = ProjectTableViewCell()
    
    var layoutDelegate: ProjectsLayoutViewControllerDelegate!
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
    
    
    
    // MARK: Public
    
    func updateWith(projects: [Project]) -> () {
        self.projects = projects
    }
    
    
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
}
