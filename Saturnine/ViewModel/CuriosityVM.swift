//
//  CuriosityViewModel.swift
//  QuazarV4
//
//  Created by Will on 4/12/21.
//

import Foundation

class CuriosityViewModel: ObservableObject {
    @Published var curiosity: Curiosity
    private var dataSource: DataSource
    private var restClient: RESTClient
    var fetchSuccess: Bool? = nil
    var date = Date() {
        didSet {
            loadCuriosityPhotos()
        }
    }
    

    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
        curiosity = Curiosity()
        date = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.day! -= 3
        date = Calendar.current.date(from: dateComponents)!
    }
    
    func loadCuriosityPhotos() {
        getNextCuriosityPhotos { success in
            if success {
                print("Successfully fetched Curiosity")
            } else {
                print("Error: unable to load Curiosity")
            }
        }
    }
    
    private func getNextCuriosityPhotos(completion: @escaping(Bool) -> Void) {
        dataSource.setDate(currentDate: date)
        dataSource.getCuriosityPhotos() { latestPhotos, _ in
            DispatchQueue.main.async {
                if let photos = latestPhotos {
                    self.curiosity = photos
                    if photos.photos!.count > 0 {
                        self.fetchSuccess = true
                    } else {
                        self.fetchSuccess = false
                    }
                    completion(true)
                } else {
                    self.fetchSuccess = false
                    completion(false)
                }
            }
        }
    }
}
