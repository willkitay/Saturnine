//
//  SpiritViewModel.swift
//  QuazarV4
//
//  Created by Will on 4/12/21.
//
import SwiftUI
import Foundation

class SpiritViewModel: ObservableObject {
    @Published var spirit: Spirit
    private var dataSource: DataSource
    private var restClient: RESTClient
    var date = Date() {
        didSet {
            loadSpiritPhotos()
        }
    }

    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
        spirit = Spirit()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.date(from: "2010/2/9")!
    }
    
    func loadSpiritPhotos() {
        getNextSpiritPhotos { success in
            if success {
                print("Successfully fetched Spirit")
            } else {
                print("Error: unable to load Spirit")
            }
        }
    }

    private func getNextSpiritPhotos(completion: @escaping(Bool) -> Void) {
        dataSource.setDate(currentDate: date)
        dataSource.getSpiritPhotos() { latestPhotos, _ in
            DispatchQueue.main.async {
                if let photos = latestPhotos {
//                    ForEach(photos, id: \.id) { photo in
//                        photo.url = photo.url.replacingOccurrences(of: "http", with: "https")
//                    }
                    
                    self.spirit = photos
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
