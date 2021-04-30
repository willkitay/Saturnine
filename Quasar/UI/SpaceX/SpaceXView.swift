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
                LazyVStack {
                    ForEach(viewModel.launchFeed, id: \.date) { launch in
                        if let url = launch.links?.flickr?.original?.first,
                           let images = launch.links?.flickr?.original,
                           let explanation = launch.details,
                           let date = launch.date,
                           let title = launch.name {
                            NavigationLink(destination: SpaceXDetailView(images: images, url: url, title: title, explanation: explanation, date: formatDateFromStringToString(date: date))) {
                                ImageView(title: title, url: url)
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("SpaceX Rocket Launches", displayMode: .automatic)
    }
}

struct SpaceXDetailView: View {
    var images: [String]
    @State var url: String
    var title: String
    var explanation: String
    var date: String
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    PhotoTitle(title: title)
                    NavigationLink(destination: FullScreenView(url: url, title: title)) {
                        KFImage(URL(string: url))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                            .animation(.easeInOut)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if images.count > 1 {
                            ForEach(images, id: \.self) { image in
                                KFImage(URL(string: image))
                                    .resizable()
                                    .frame(width: 110, height: 110)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            url = image
                                        }
                                    }
                                    .transition(.move(edge: .top))
                            }
                        }
                    }.padding([.leading, .trailing])
                }
                VStack {
                    PhotoDate(date: date)
                        .font(.headline)
                        .padding(.top)
                    Explanation(text: explanation)
                }
                    .background(Color.background2)
                    .cornerRadius(5)
                    .padding([.leading, .trailing, .bottom], 10)
                    .foregroundColor(.white)
                    .transition(.opacity)
                Spacer()
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
