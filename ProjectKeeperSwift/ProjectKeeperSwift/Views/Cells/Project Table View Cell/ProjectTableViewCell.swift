//
//  ProjectTableViewCell.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/21/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

let projectTableViewCellReuseId = "projectTableViewCellReuseId"

protocol ProjectTableViewCellDelegate {
    
    func loadImageForProject(project: Project, onComplete:(UIImage) -> ())
    
}

class ProjectTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var solutionTypes: UILabel!
    @IBOutlet weak var projectImageWidthLayoutConstraint: NSLayoutConstraint!
    
    var currentProject:Project?
    var delegate: ProjectTableViewCellDelegate?
    
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    override func prepareForReuse() {
        projectName.text = nil
        year.text = nil
        projectImageView.image = UIImage(named: "project-placeholder-image")
    }
    
    
    
    // MARK: Public
    
    class func cellNib() -> UINib {
        return UINib.init(nibName: String(self), bundle: nil)
    }
    
    class func registerInTableView(tableView: UITableView) -> () {
        let cellNib = ProjectTableViewCell.cellNib()
        tableView.registerNib(cellNib, forCellReuseIdentifier: projectTableViewCellReuseId)
    }
    
    class func projectTableViewCellWith(project: Project, delegate:ProjectTableViewCellDelegate, indexPath: NSIndexPath, tableView: UITableView) -> (ProjectTableViewCell) {
        let cell = tableView.dequeueReusableCellWithIdentifier(projectTableViewCellReuseId, forIndexPath: indexPath) as! ProjectTableViewCell
        cell.delegate = delegate
        cell.updateWith(Project: project)
        return cell
    }

    
    
    // MARK: Private
    
    private func updateWith(Project project: Project) -> () {
        currentProject = project
        projectName.text = project.projectName
        year.text = String(project.releaseYear)
        
        let attributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: solutionTypes.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
                          
        let myString = NSMutableAttributedString(string: "Solution Types: ", attributes: attributes )
        let attrString = NSAttributedString(string: project.solutionTypes.joinWithSeparator(", "))
        
        myString.appendAttributedString(attrString)
        
        solutionTypes.attributedText = myString
        delegate?.loadImageForProject(project, onComplete: { (image) in
            if project == self.currentProject {
                self.projectImageView.image = image
            }
        })
    }
    
    private func setupAppearance() {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            self.projectImageWidthLayoutConstraint.constant = 200
        default:
            self.projectImageWidthLayoutConstraint.constant = 100
        }
    }
}
