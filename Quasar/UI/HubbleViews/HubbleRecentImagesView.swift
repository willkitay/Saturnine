//
//  HubbleRecentImagesView.swift
//  Quasar
//
//  Created by Will on 4/20/21.
//

import SwiftUI
import Kingfisher

struct HubbleRecentImagesView: View {
    @ObservedObject var viewModel: HubbleRecentImagesViewModel
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: true) {
                ForEach(viewModel.imageFeed, id: \.title) { photo in
                    LazyVStack {
                        if let title = photo.title,
                           let explanation = photo.description,
                           let date = photo.pubDate,
                           let url = photo.image {
                            NavigationLink(destination: DetailView(url: validateUrl(url: url), title: title, explanation: explanation, date: formatDateFromStringToString(date: date))) {
                                ImageView(title: title, url: validateUrl(url: url))
                            }
                        }
                    }
                }
            }.navigationBarTitle("Hubble Telescope Live", displayMode: .large)
        }
    }
    
    func validateUrl(url: String) -> String {
        let urlString = "https:\(url)"
        return urlString
    }
}

private func formatDateFromStringToString(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: date) else { return "error date is nil" }
    
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}
