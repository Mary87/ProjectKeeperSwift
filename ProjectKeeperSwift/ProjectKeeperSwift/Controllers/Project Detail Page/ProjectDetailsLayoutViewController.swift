//
//  ProjectDetailsLayoutViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/23/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ProjectDetailsLayoutViewControllerDelegate {
    
}

class ProjectDetailsLayoutViewController: UITableViewController {
    
    enum ProjectInfoType: Int {
        case baseInformation
        case description
        case clientName
        case technologies
        case solutionTypes
        case assets
    }
    
    // MARK: Properties
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var supportedScreensLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var solutionTypesLabel: UILabel!
    @IBOutlet weak var technologiesLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    
    @IBOutlet weak var baseInformationCell: UITableViewCell!
    @IBOutlet weak var descriptionCell: UITableViewCell!
    @IBOutlet weak var clientNameCell: UITableViewCell!
    @IBOutlet weak var solutionTypesCell: UITableViewCell!
    @IBOutlet weak var technologiesCell: UITableViewCell!
    @IBOutlet weak var assetsCell: UITableViewCell!
    
    var currentProject: Project!
    var layoutDelegate: ProjectDetailsLayoutViewControllerDelegate!
    
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        updateWithProjectInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTableViewContentDictionary().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contentDictionary = getTableViewContentDictionary()
        let cellType = contentDictionary[indexPath.row]
        let cell = cellForInfoType(cellType!)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    
    // MARK: Public
    
    func updateWithProject(project: Project) -> () {
        currentProject = project
        tableView.reloadData()
    }
    
    
    
    // MARK: Private
    
    private func cellForInfoType(infoType: ProjectInfoType) -> UITableViewCell {
        switch infoType {
        case .baseInformation:
            return baseInformationCell
        case .description:
            return descriptionCell
        case .clientName:
            return clientNameCell
        case .solutionTypes:
            return solutionTypesCell
        case .technologies:
            return technologiesCell
        case .assets:
            return assetsCell
        }
    }
    
    private func infotypeForCell(cell: UITableViewCell) -> ProjectInfoType? {
        if cell == baseInformationCell {
            return .baseInformation
        }
        else if cell == descriptionCell {
            return .description
        }
        else if cell == clientNameCell {
            return .clientName
        }
        else if cell == solutionTypesCell {
            return .solutionTypes
        }
        else if cell == technologiesCell {
            return .technologies
        }
        else if cell == assetsCell {
            return .assets
        }
        else {
            return nil
        }
    }
    
    private func updateWithProjectInfo() {
        projectNameLabel.text = currentProject.projectName
        releaseYearLabel.text = String(currentProject.releaseYear)
        
        descriptionLabel.text = currentProject.projectDescription
        
        
        // Configure Solution Types label
        let solutionTypesAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: solutionTypesLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let solutionTypesAttrString = NSMutableAttributedString(string: "Solution Types: ", attributes: solutionTypesAttributes)
        let joinedTypesAttrString = NSAttributedString(string: currentProject.solutionTypes.joinWithSeparator(", "))
        
        solutionTypesAttrString.appendAttributedString(joinedTypesAttrString)
        solutionTypesLabel.attributedText = solutionTypesAttrString
        
        // Configure Technologies label
        let technologiesAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Medium", size: technologiesLabel.font.pointSize)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let technologiesAttrString = NSMutableAttributedString(string: "Technologies: ", attributes: technologiesAttributes)
        let joinedTechnologiesAttrString = NSAttributedString(string: currentProject.technologies.joinWithSeparator(", "))
        
        technologiesAttrString.appendAttributedString(joinedTechnologiesAttrString)
        technologiesLabel.attributedText = technologiesAttrString
    }
    
    private func getTableViewContentDictionary() -> [Int : ProjectInfoType] {
        var availableCellsDict = [Int: ProjectInfoType]()
        var cellIndex = 0
        availableCellsDict[cellIndex] = ProjectInfoType.baseInformation
        if !currentProject.projectDescription.isEmpty {
            cellIndex += 1
            availableCellsDict[cellIndex] = ProjectInfoType.description
        }
        if  currentProject.client != nil && !(currentProject.client!.clientName.isEmpty) {
            cellIndex += 1
            availableCellsDict[cellIndex] = ProjectInfoType.clientName
        }
        if !currentProject.solutionTypes.isEmpty {
            cellIndex += 1
            availableCellsDict[cellIndex] = ProjectInfoType.solutionTypes
        }
        if !currentProject.technologies.isEmpty {
            cellIndex += 1
            availableCellsDict[cellIndex] = ProjectInfoType.technologies
        }
        if !currentProject.assets.isEmpty {
            cellIndex += 1
            availableCellsDict[cellIndex] = ProjectInfoType.assets
        }
        return availableCellsDict
    }

    

}
