//
//  ProjectTableViewCell.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var solutionTypes: UILabel!
    
    
    
    // MARK: Lifecycle
    
    
    // 
    
    func updateWith(Project project: Project) -> () {
        projectName.text = project.projectName
        year.text = String(project.releaseYear)
    }
    
}
