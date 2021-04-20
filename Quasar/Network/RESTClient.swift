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
