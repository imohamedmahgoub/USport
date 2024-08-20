//
//  Internet Connectivity.swift
//  Usport
//
//  Created by Mohamed Mahgoub on 17/08/2024.
//

import Network
import Foundation

class InternetConnection{
    
    static func checkURL(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://www.google.com") else {
            completion(false)
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 5)
        
        URLSession(configuration: .default).dataTask(with: request) { _, response, error in
            var success = false
        
            if let httpsResponse = response as? HTTPURLResponse,
               httpsResponse.statusCode == 200,
               error == nil {
                success = true
            }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }.resume()
    }
    
}
