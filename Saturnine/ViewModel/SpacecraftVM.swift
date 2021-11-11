//
//  SpacecraftVM.swift
//  Saturnine
//
//  Created by William Kitay on 9/18/21.
//

import Foundation

class SpacecraftVM: ObservableObject {
    @Published var spacecraftList: SpacecraftList
    private var datasource: DataSource
    private var restClient: RESTClient
    var fetchSuccess: Bool? = nil
    
    init() {
        restClient = SimpleRESTClientSpacedevs()
        datasource = DataSource(withClient: restClient)
        spacecraftList = SpacecraftList(count: 0, next: "", results: nil)
    }
    
    func loadSpacecraftList() {
        getNextSpacecraftList { success in
            if success {
                print("fetched SpacecraftList")
                self.fetchSuccess = true
            } else {
                print("Error: unable to load SpacecraftList")
                self.fetchSuccess = false
            }
        }
    }
    
    private func getNextSpacecraftList(completion: @escaping(Bool) -> Void) {
        datasource.getSpacecraft() { spacecraftList, _ in
            DispatchQueue.main.async {
                if let spacecraft = spacecraftList {
                    self.spacecraftList = spacecraft
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
