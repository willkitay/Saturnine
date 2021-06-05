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
                        NavigationLink(destination: HorizontalHubbleFeed(title: photo.title, viewModel: viewModel)) {
                            ImageView(title: photo.title, url: validateUrl(photo.image))
                        }
                    }
                }
            }
        }
    }
}

struct HorizontalHubbleFeed: View {
    @ObservedObject var viewModel: HubbleRecentImagesViewModel
    @State var currentTitle = ""
    
    init(title: String, viewModel: HubbleRecentImagesViewModel) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    HubblePageView(viewModel: viewModel, currentTitle: currentTitle)
                }
            }
        }
    }
}

struct HubblePageView: View {
    @ObservedObject var viewModel: HubbleRecentImagesViewModel
    @State var currentTitle: String
    
    var body: some View {
        TabView(selection: $currentTitle) {
            if let photos = viewModel.imageFeed {
                ForEach(photos, id: \.title) { photo in
                    let explanation = photo.description
                    let date = photo.pubDate
                    let title = photo.title
                    ScrollView {
                        NavigationLink(destination: FullScreenView(url: validateUrl(photo.image), title: title)) {
                            KFImage(URL(string: validateUrl(photo.image))).resizable().scaledToFit()
                        }
                        .padding(.top, 62)
                        PhotoDetailsView(explanation: explanation, date: formatDate(date), title: title)
                            .padding(.bottom, 55)
                    }.tag(title)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}

private func formatDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: date) else { return "error date is nil" }
    
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}

func validateUrl(_ url: String) -> String {
    let urlString = "https:\(url)"
    return urlString
}
