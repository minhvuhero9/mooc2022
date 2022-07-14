//
//  ConnectionManager.swift
//  Mooc2022
//
//  Created by Minh Vũ Lê on 14/07/2022.
//

import Foundation
import Reachability

class ConnectionManager: NSObject {
    
    // Create a singleton instance
    static let shared = ConnectionManager()
    
    private var reachability: Reachability!
    var connectInternet: () -> Void = { }
    private (set) var isConnect: Bool = true {
        didSet {
            if !self.isConnect {
                
            }
        }
    }
    
    override init() {
        super.init()
        // Initialise reachability
        do {
            self.reachability = try Reachability()
        } catch {
            return
        }
        
        self.configNetwork()
        
        do {
            // Start the network status notifier
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func configNetwork() {
        self.reachability.whenReachable = { _ in
            self.isConnect = true
            self.connectInternet()
        }
        
        self.reachability.whenUnreachable = { _ in
            self.isConnect = false
        }
    }
    
}
