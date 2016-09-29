//
//  BaseViewController.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/26/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties
    
    let webImageLoader = InstancesFabric.webImageLoader()
    
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: Public

    func showLoadingOverlay() ->  () {
        let overlayView = LoadingOverlayView.init(frame: self.view.frame)
        self.view.addSubview(overlayView)
    }
    
    func hideLoadingOverlay() -> () {
        for view in self.view.subviews {
            if let overlayView = view as? LoadingOverlayView {
                overlayView.removeFromSuperview()
            }
        }
    }
}
