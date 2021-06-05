//
//  HubbleRecentImagesViewModel.swift
//  Quasar
//
//  Created by Will on 4/20/21.
//

import Foundation

class HubbleRecentImagesViewModel: ObservableObject {
    @Published var imageFeed: [HubbleSite] = []
    private var dataSource: DataSource
    private var restClient: RESTClient
    
    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
    }
    
    func loadRecentImages() {
        getMoreHubbleImages { success in
            if success {
                print("Successfully fetched recent Hubble images")
            } else {
                print("Error: unable to load recent Hubble images")
            }
        }
    }
    
    // TODO: remove duplicates from array
    private func getMoreHubbleImages(completion: @escaping(Bool) -> Void) {
        dataSource.getHubbleRecentImages() { images, _ in
            DispatchQueue.main.async {
                if let photos = images {
                    self.imageFeed.append(contentsOf: photos)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}

