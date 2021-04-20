//
//  OpportunityViewModel.swift
//  QuazarV4
//
//  Created by Will on 4/12/21.
//

import Foundation
import SwiftUI

class OpportunityViewModel: ObservableObject {
    @Published var opportunity: Opportunity
    private var dataSource: DataSource
    private var restClient: RESTClient
    var date = Date() {
        didSet {
            loadOpportunityPhotos()
        }
    }

    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
        opportunity = Opportunity()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.date(from: "2018/6/5")!
    }

    private func getNextOpportunityPhotos(completion: @escaping(Bool) -> Void) {
        dataSource.setDate(currentDate: date)
        dataSource.getOpportunityPhotos() { latestPhotos, _ in
            DispatchQueue.main.async {
                if let photos = latestPhotos {
                    self.opportunity = photos
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func loadOpportunityPhotos() {
        getNextOpportunityPhotos { success in
            if success {
                print("Successfully fetched Opportunity")
            }
            else {
                print("Error: unable to load Opportunity")
            }
        }
    }
    
    private func setDate(newDate: Date) {
        date = newDate
    }
}
