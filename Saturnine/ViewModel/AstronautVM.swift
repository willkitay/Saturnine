//
//  AstronautVM.swift
//  Saturnine
//
//  Created by William Kitay on 9/19/21.
//

import Foundation

class AstronautVM: ObservableObject {
    @Published var astronautList: AstronautList
    private var datasource: DataSource
    private var restClient: RESTClient
//    private var useNext: Bool
    
    init() {
        restClient = SimpleRESTClientSpacedevs()
        datasource = DataSource(withClient: restClient)
        astronautList = AstronautList(count: 0, next: "", results: nil)
//        useNext = false
    }
    
//    func isLastAstronaut(astronaut: Astronaut) -> Bool {
//        if let last = self.astronautList.results?.last {
//            useNext = true
//            return last == astronaut
//        }
//        return false
//    }
    
    func loadAstronautList() {
        getNextAstronautList { success in
            if success {
                print("fetched AstronautList")
            } else {
                print("Error: unable to fetch AstronautList")
            }
        }
    }
    
    private func getNextAstronautList(completion: @escaping(Bool) -> Void) {
        datasource.getAstronauts() { astronautList, _ in
            DispatchQueue.main.async {
                if let astronaut = astronautList {
                    self.astronautList = astronaut
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
