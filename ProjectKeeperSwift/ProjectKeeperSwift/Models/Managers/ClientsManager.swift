//
//  ClientsManager.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/28/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ClientsManagerProtocol {
    
    func loadClientForProject(project: Project, onComplete: (Project) -> ())
    
}

class ClientsManager: BaseManager, ClientsManagerProtocol {
    
    // MARK: Properties
    
    let clientsRepository = InstancesFabric.clientsRepository()
    
    
    
    // MARK: ClientsManagerProtocol 
    
    func loadClientForProject(project: Project, onComplete: (Project) -> ()) {
        clientsRepository.loadClients({ (clients) -> (Void) in
            for client in clients {
                if client.clientId == project.clientId {
                    project.client =  client
                    onComplete(project)
                }
            } // TODO: make with .filter
        })
    }

}
