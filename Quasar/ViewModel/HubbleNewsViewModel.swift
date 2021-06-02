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
        getMoreNews { success in
            if success {
                print("Successfully fetched news")
            } else {
                print("Error: unable to load news")
            }
        }
    }
    
    private func getMoreNews(completion: @escaping(Bool) -> Void) {
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
