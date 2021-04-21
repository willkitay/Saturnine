//
//  HubbleNewsViewModel.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import Foundation

class HubbleNewsViewModel: ObservableObject {
    @Published var newsFeed: [HubbleSite] = []
    private var dataSource: DataSource
    private var restClient: RESTClient
    
    init() {
        restClient = SimpleRESTClient()
        dataSource = DataSource(withClient: restClient)
    }
    
    func loadNewsFeed() {
        getMoreHubbleNews { success in
            if success {
                print("Successfully fetched Hubble News")
            } else {
                print("Error: unable to load Hubble News")
            }
        }
    }
    
    private func getMoreHubbleNews(completion: @escaping(Bool) -> Void) {
        dataSource.getHubbleNews() { articles, _ in
            DispatchQueue.main.async {
                if let newsArticles = articles {
                    self.newsFeed.append(contentsOf: newsArticles)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
