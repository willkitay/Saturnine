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
            ScrollView() {
                VStack {
                    ForEach(viewModel.imageFeed, id: \.title) { photo in
                        if let title = photo.title,
                           let explanation = photo.description,
                           let date = photo.pubDate,
                           let image = photo.image {
                            NavigationLink(destination: HubbleDetailView(title: title, image: image, explanation: explanation, date: date)) {
                                HubbleImageView(image: image, title: title)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Hubble Telescope Live", displayMode: .large)
    }
}

struct HubbleImageView: View {
    var image: String
    var title: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(URL(string: "https:" + image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.1)
                )
                .padding(.leading)
                .padding(.bottom, 2)
                .overlay(TitleOverlay(text: title), alignment: .bottomTrailing).padding(.trailing)
        }
    }
}

struct HubbleDetailView: View {
    var title: String
    var image: String
    var explanation: String
    var date: String
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack() {
                    VStack {
                        NavigationLink(destination: FullScreenView(url: "https:\(image)", title: title)) {
                            KFImage(URL(string: "https:" + image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        PhotoDetailsView(explanation: explanation, copyright: " ", date: formatDateFromStringToString(date: date), title: title)
                    }
                }
            }
        }
    }
}

struct HubbleFullScreenView: View {
    var url: String
    var title: String
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            ZoomableScrollView {
                ZStack {
                    Color.background.ignoresSafeArea(.all)
                    KFImage(URL(string: url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
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
