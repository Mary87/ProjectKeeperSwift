//
//  InstancesFabric.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/28/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import Foundation

struct InstancesFabric {
    
    // MARK: Managers Instances
    
    static func projectsManager() -> ProjectsManagerProtocol {
        return ProjectsManager()
    }
    
    static func assetsManager() -> AssetsManagerProtocol {
        return AssetsManager()
    }
    
    static func clientsManager() -> ClientsManagerProtocol {
        return ClientsManager()
    }
    
    
    
    // MARK: Repositories Instances
    
    static func projectsRepository() -> ProjectsRepositoryProtocol {
        return ProjectsReprository()
    }
    
    static func assetsRepository() -> AssetsRepositoryProtocol {
        return AssetsRepository()
    }
    
    static func clientsRepository() -> ClientsRepositoryProtocol {
        return ClientsRepository()
    }
    
    
    
    // MARK: Loaders Instances
    
    static func webImageLoader() -> WebImageLoaderProtocol {
        return WebImageLoader()
    }
    
    
    
    // MARK: Data Services Instances
    
    static func webDataService() -> WebDataServiceProtocol {
        return WebDataService()
    }
    
    
}
