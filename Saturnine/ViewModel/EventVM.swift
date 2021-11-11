//
//  EventVM.swift
//  Saturnine
//
//  Created by William Kitay on 10/27/21.
//

import Foundation

class EventVM: ObservableObject {
    @Published var eventList: EventList
    private var datasource: DataSource
    private var restClient: RESTClient
    var fetchSuccess: Bool? = nil
    
    init() {
        restClient = SimpleRESTClientSpacedevs()
        datasource = DataSource(withClient: restClient)
        eventList = EventList(count: 0, next: "", results: nil)
    }
    
    func loadEventList() {
        getNextEventList { success in
            if success {
                print("fetched EventList")
                self.fetchSuccess = true
            } else {
                print("Error: unable to fetch EventList")
                self.fetchSuccess = false
            }
        }
    }
    
    private func getNextEventList(completion: @escaping(Bool) -> Void) {
        datasource.getEvents() { eventList, _ in
            DispatchQueue.main.async {
                if let events = eventList {
                    self.eventList = events
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
