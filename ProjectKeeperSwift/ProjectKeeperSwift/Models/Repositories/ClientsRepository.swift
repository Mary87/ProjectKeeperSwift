//
//  ClientsRepository.swift
//  ProjectKeeperSwift
//
//  Created by Mary  on 9/22/16.
//  Copyright © 2016 3ss. All rights reserved.
//

import UIKit

protocol ClientsRepositoryProtocol {
    
    func loadClients(onComplete: ([Client]) -> (Void))
    
}

class ClientsRepository: BaseRepository, ClientsRepositoryProtocol {
    
    // MARK: Public
    
    func loadClients(onComplete: ([Client]) -> (Void)) {
        let clientsUrl = environment.clientsUrl
        webDataService.getDataFromUrl(clientsUrl) { (jsonData) -> (Void) in
            onComplete(self.extractCliensFromData(jsonData))
        }
    }
    
    
    
    // MARK: Private
    
    private func extractCliensFromData(jsonData: NSData?) -> [Client] {
        var clientsArray = [Client]()
        do {
            let clientsDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:.AllowFragments) as? [String: [AnyObject]]
            if let clients = clientsDict!["clients"] {
                for client in clients {
                    if let newClient = Client.init(parametersDictionary: client as! Dictionary<String, AnyObject>) {
                        clientsArray.append(newClient)
                    }
                }
            }
        }
        catch {
            print("Error with Json: \(error)")
        }
        
        return clientsArray
    }
    
    
    
}
