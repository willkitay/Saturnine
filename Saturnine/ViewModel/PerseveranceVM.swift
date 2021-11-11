//
//  MarsRoversViewModel.swift
//  Saturnine
//
//  Created by Will on 4/4/21.
//

import Foundation

class PerseveranceViewModel: ObservableObject {
    @Published var perseverance: Perseverance
    private var dataSource: DataSource
    private var restClient: RESTClient
    var fetchSuccess: Bool? = nil
    var date = Date() {
        didSet {
            loadPerseverancePhotos()
        }
    }
    
    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
        perseverance = Perseverance()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        dateComponents.day! -= 3
        date = Calendar.current.date(from: dateComponents)!
    }
    
    func loadPerseverancePhotos() {
        getNextPerseverancePhotos { success in
            if success {
                print("Successfully fetched Perseverance")
            } else {
                print("Error: unable to load Perseverance")
            }
        }
    }

    private func getNextPerseverancePhotos(completion: @escaping(Bool) -> Void) {
        dataSource.setDate(currentDate: date)
        dataSource.getPerseverancePhotos() { latestPhotos, _ in
            DispatchQueue.main.async {
                if let photos = latestPhotos {
                    self.perseverance = photos
                    if photos.photos!.count > 0 {
                        self.fetchSuccess = true
                    } else {
                        self.fetchSuccess = false
                    }
                    completion(true)
                } else {
                    completion(false)
                    self.fetchSuccess = false
                }
            }
        }
    }
}
