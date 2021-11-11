//
//  SpaceXLaunchViewModel.swift
//  Saturnine
//
//  Created by Will on 4/21/21.
//

import Foundation

class SpaceXViewModel: ObservableObject {
    @Published var launchFeed: [SpaceX] = []
    private var dataSource: DataSource
    private var restClient: RESTClient
    var fetchSuccess: Bool? = nil
    
    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
    }
    
    func loadLaunchFeed() {
        getLaunchFeed { success in
            if success {
                print("Successfully fetched SpaceX Launches")
            } else {
                print("Error: unable to load SpaceX Launches")
            }
        }
    }

    private func getLaunchFeed(completion: @escaping(Bool) -> Void) {
        dataSource.getSpaceXLaunches() { launches, _ in
            DispatchQueue.main.async {
                if let launches = launches {
                    self.launchFeed.append(contentsOf: launches.reversed())
                    self.fetchSuccess = true
                    completion(true)
                } else {
                    completion(false)
                    self.fetchSuccess = false
                }
            }
        }
    }
    
    func emptyData() {
        launchFeed.removeAll()
    }
}
