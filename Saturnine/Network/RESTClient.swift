//
//  RESTClient.swift
//  Saturnine
//
//  Created by Will on 4/19/21.
//

import Foundation

let token = "7264bbbf3ff5985904d465119527c1051c06b621"

enum RESTClientError : Error {
    case error(String)
}

protocol RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void)
}

class SimpleRESTClientSpacedevs: RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void) {
        var url = URLRequest(url: url)
        url.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data)
        
        }
        task.resume()
    }
}

class SimpleRESTClient: RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data)
        }
        task.resume()
    }
}



