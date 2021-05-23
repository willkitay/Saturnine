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
                VStack(alignment: .leading) {
                    Image("HubbleTelescopeLogo")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom])
                        .padding([.leading, .trailing], 40)
                    FeedHeader(title: "Hubble Space Telescope", text: "The Hubble Space Telescope takes sharp pictures of objects in the sky such as planets, stars and galaxies. Hubble has made more than one million observations. These include detailed pictures of the birth and death of stars, galaxies billions of light years away, and comet pieces crashing into Jupiter's atmosphere.")
                }
                ForEach(viewModel.imageFeed, id: \.title) { photo in
                    LazyVStack {
                        NavigationLink(destination: DetailView(url: validateUrl(url: photo.image), title: photo.title, explanation: photo.description, date: formatDateFromStringToString(date: photo.pubDate))) {
                            ImageView(title: photo.title, url: validateUrl(url: photo.image))
                        }
                    }
                }
            }
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
