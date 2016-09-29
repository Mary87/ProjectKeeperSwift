//
//  WebDataService.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol WebDataServiceProtocol {
    
    func getDataFromUrl(url:String, onComplete:(NSData)? -> (Void))

}

class WebDataService: WebDataServiceProtocol {
    
    static let sharedInstance = WebDataService()
    
    private init () {
    }
    
    func getDataFromUrl(url:String, onComplete:(NSData)? -> (Void)) {
        let url = NSURL(string: url)
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        urlRequest.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        
        let tast = session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (error != nil || statusCode != 200) {
                print(String(self) + ": Loading FAILED for url \(url)\n Error has occured during data loading. \n Error code: \(statusCode)\nDescription: \(error?.description)")
            }
            else {
                print(String(self) + ": Loading FINISHED from url \(url).")
            }
            onComplete(data)
        }
        print(String(self) + ": Loading STARTED for ulr \(url) ")
        tast.resume()
    }
    
}
