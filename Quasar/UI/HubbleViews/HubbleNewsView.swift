//
//  HubbleNewsView.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI
import Kingfisher

struct HubbleNewsView: View {
    @ObservedObject var viewModel: HubbleNewsViewModel
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView() {
                VStack {
                    ForEach(viewModel.newsFeed, id: \.title) { article in
                        if let title = article.title,
                           let date = article.pubDate,
                           let thumbnail = article.thumbnail,
                           let link = article.link {
                            Link(destination: URL(string: link)!) {
                                ArticleRow(title: title, date: date, thumbnail: thumbnail)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Hubble News", displayMode: .large)
    }
}

struct ArticleRow: View {
    var title: String
    var date: String
    var thumbnail: String
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                KFImage(URL(string: "https:" + thumbnail))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                    Spacer()
                    Text(formatDateFromStringToString(date: date))
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(.leading, 5)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.black, lineWidth: 0))
        }
        .padding([.leading, .trailing])
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
