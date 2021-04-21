//
//  POTDView.swift
//  Quasar
//
//  Created by Will on 3/19/21.
//

import SwiftUI
import Kingfisher

struct POTDView: View {
    @ObservedObject var viewModel: POTDViewModel
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                LazyVStack (alignment: .leading) {
                    ForEach(viewModel.imageFeed, id: \.title) { photo in
                        if let url = photo.url,
                           let explanation = photo.explanation,
                           let title = photo.title,
                           let copyright = photo.copyright,
                           let date = photo.date {
                            NavigationLink(destination: POTDDetailView(url: url, title: title, explanation: explanation, copyright: copyright, date: date)) {
                                POTDImageView(title: title, url: url).onAppear() { self.elementOnAppear(photo) }
                            }
                            .padding(.bottom, 2)
                            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
                            .navigationBarTitle("Picture of the Day", displayMode: .automatic)
                        }
                    }
                }
            }
        }
    }
    
    private func elementOnAppear(_ photo: PictureOfTheDay) {
        if viewModel.isLastPOTD(photo: photo) {
            viewModel.loadPicturesOfTheDay()
        }
    }
}

struct POTDImageView: View {
    var title: String
    var url: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(URL(string: url))
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
