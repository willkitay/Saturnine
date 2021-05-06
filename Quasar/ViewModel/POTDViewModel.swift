//
//  POTDViewModel.swift
//  QuazarV4
//
//  Created by Will on 3/19/21.
//

import Foundation

class POTDViewModel: ObservableObject {
    @Published var imageFeed: [PictureOfTheDay] = []
    
    private var dataSource: DataSource
    private var restClient: RESTClient
    
    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
    }
    
    func isLastPOTD(photo: PictureOfTheDay) -> Bool {
        if let last = self.imageFeed.last {
            return last == photo
        }
        return false
    }
    
    func loadPicturesOfTheDay() {
        getNextPOTD { success in
            if success {
                print("Successfully fetched Pictures of the Day")
            } else {
                print("Error: unable to load Pictures of the Day")
            }
        }
    }

    private func getNextPOTD(completion: @escaping(Bool) -> Void) {
        dataSource.getPicturesOfTheDay() { photos, _ in
            DispatchQueue.main.async {
                if var photos = photos {
                    photos = photos.filter { $0.media_type == "image" }
                    self.imageFeed.append(contentsOf: photos.reversed())
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
