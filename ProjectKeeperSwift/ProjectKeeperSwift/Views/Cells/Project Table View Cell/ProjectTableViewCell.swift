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
    
    func loadThumbnailImageForProject(project: Project, onComplete: (UIImage) -> ())
    
}



class ProjectTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var solutionTypesLabel: UILabel!
    
    var currentProject: Project?
    var delegate: ProjectTableViewCellDelegate?
    
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAppearance()
    }
    
    override func prepareForReuse() {
        projectNameLabel.text = nil
        releaseYearLabel.text = nil
        projectImageView.image = UIImage(named: "placeholder-image")
        currentProject = nil
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
            cellContentView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 140.0/255.0, blue: 185.0/255.0, alpha: 1)
            projectNameLabel.textColor = UIColor.whiteColor()
        }
        else {
            cellContentView.backgroundColor = UIColor.init(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1)
            projectNameLabel.textColor = UIColor.init(red: 0.0/255.0, green: 140.0/255.0, blue: 185.0/255.0, alpha: 1)
        }
    }
    
    
    
    // MARK: Public
    
    class func cellNib() -> UINib {
        var nibName = String(self)
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            nibName += "~iPad"
        default:
            nibName += "~iPhone"
        }
        return UINib.init(nibName: nibName, bundle: nil)
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
        
        projectNameLabel.text = project.projectName
        
        // Configure Solution Types label.
        
        let solutionTypesAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: solutionTypesLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        let solutionTypesAttrString = NSMutableAttributedString(string: "Solution Types: ", attributes: solutionTypesAttributes)

        var joinedTypesAttrString = NSAttributedString(string: project.solutionTypes.joinWithSeparator(", "))
        if UIDevice.currentDevice().userInterfaceIdiom != .Pad  {
            joinedTypesAttrString = NSAttributedString(string: "\n" + joinedTypesAttrString.string)
        }
        solutionTypesAttrString.appendAttributedString(joinedTypesAttrString)
        solutionTypesLabel.attributedText = solutionTypesAttrString
        
        // Configure Release Year label.
        
        let releaseYearAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: releaseYearLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        let releaseYearAttrString = NSMutableAttributedString(string: "Release year ", attributes: releaseYearAttributes)
        if project.releaseYear > 0 {
            releaseYearAttrString.appendAttributedString(NSAttributedString.init(string: String(project.releaseYear)))
        }
        else {
            releaseYearAttrString.appendAttributedString(NSAttributedString(string: "-"))
        }
        releaseYearLabel.attributedText = releaseYearAttrString
        
        delegate?.loadThumbnailImageForProject(project, onComplete: { (image) in
            if project == self.currentProject {
                self.projectImageView.image = image
            }
        })
    }
    
    private func setupAppearance() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
}
