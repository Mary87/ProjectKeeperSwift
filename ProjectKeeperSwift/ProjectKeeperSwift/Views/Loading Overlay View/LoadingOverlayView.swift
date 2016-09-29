//
//  LoadingOverlayView.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/26/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

class LoadingOverlayView: UIView {
    
    // MARK: Initialization

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.init(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1)
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRectMake(0, 0, 40, 40)
        activityIndicator.activityIndicatorViewStyle = .White
        activityIndicator.center = CGPointMake(self.bounds.width / 2, self.bounds.height / 2)
        
        self.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
