//
//  SpaceXView.swift
//  Quasar
//
//  Created by Will on 4/21/21.
//

import SwiftUI
import Kingfisher

struct SpaceXView: View {
    @ObservedObject var viewModel: SpaceXViewModel

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                LazyVStack (alignment: .leading) {
                    ForEach(viewModel.launchFeed, id: \.date) { launch in
                        if let url = launch.links?.flickr?.original?.first,
                           let explanation = launch.details,
                           let date = launch.date,
                           let title = launch.name {
                            NavigationLink(destination: DetailView(url: url, title: title, explanation: explanation, date: formatDateFromStringToString(date: date))) {
                                ImageView(title: title, url: url)
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("SpaceX Rocket Launches", displayMode: .automatic)
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
