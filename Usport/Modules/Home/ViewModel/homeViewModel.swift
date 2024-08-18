//
//  homeViewModel.swift
//  Sports
//
//  Created by Ahmed El Gndy on 14/08/2024.
//

import Foundation
import Network

class HomeViewModel {
    
    var sportArray = ["Football", "Basketball", "Cricket", "Tennis"]
    
    private var monitor: NWPathMonitor?

    func startNetworkMonitor() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    // Network is available
                    self?.notifyNetworkStatus(isConnected: true)
                } else {
                    // Network is unavailable
                    self?.notifyNetworkStatus(isConnected: false)
                }
            }
        }
    }

    private func notifyNetworkStatus(isConnected: Bool) {
        // Handle the network status change, e.g., reload data or show/hide UI elements
    }

    func numberOfItems() -> Int {
        return sportArray.count
    }
    
    func sportName(at index: Int) -> String {
        return sportArray[index]
    }
    
    func sportImageName(at index: Int) -> String {
        switch index {
        case 0: return "football.jpg"
        case 1: return "basketbell.jpg"
        case 2: return "cricket.jpg"
        case 3: return "tennis.jpg"
        default: return "basketball.jpg"
        }
    }
}
