//
//  RESTClient.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import Combine
import Foundation

enum RESTClientError : Error {
    case error(String)
}

protocol RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void)
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

class SimpleRESTClientSpacedevs: RESTClient {
    func getData(atURL url: URL, completion: @escaping (Data?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("Token 7264bbbf3ff5985904d465119527c1051c06b621", forHTTPHeaderField: "Authorization")
        print(request)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(data)
        
        }
        task.resume()
    }
}
