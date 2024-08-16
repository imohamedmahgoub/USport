//
//  Network Connection.swift
//  Usport
//
//  Created by Mohamed Mahgoub on 16/08/2024.
//


import Foundation
import Network

class InternetConnection{
    let monitor = NWPathMonitor()
    
    
    static func hasInternetConnect() -> Bool {
        guard let url = URL(string: "https://www.google.com") else { return false }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 1)
        let semaphore = DispatchSemaphore(value: 0)
        var success = false
        
        URLSession(configuration: .default).dataTask(with: request) { _, response, error in
            if let httpsResponse = response as? HTTPURLResponse,
               httpsResponse.statusCode == 200,
               error == nil {
                success = true
            }
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        return success
    }
//    private func setupNetworkMonitoring() {
//        monitor.pathUpdateHandler = { [weak self] path in
//            DispatchQueue.main.async {
//                if path.status == .satisfied {
//                    print("Internet is available")
//                    self?.fetchMoviesFromNetwork()
//                } else {
//                    print("No internet connection")
//                    self?.fetchMoviesFromCoreData()
//                }
//                self?.monitor.cancel()
//            }
//        }
//        monitor.start(queue:.main)
//    }
//    
}



