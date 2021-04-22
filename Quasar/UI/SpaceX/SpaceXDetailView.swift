//
//  SpaceXDetailView.swift
//  Quasar
//
//  Created by Will on 4/21/21.
//

import SwiftUI
import Kingfisher

struct SpaceXDetailView: View {
    var url: String
    var title: String
    var explanation: String
    var date: String

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack() {
                    VStack {
                        NavigationLink(destination: FullScreenView(url: url, title: title)) {
                            KFImage(URL(string: url))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    PhotoDetailsView(explanation: explanation, copyright: " ", date: formatDateFromStringToString(date: date), title: title)
                }
            }
            .navigationBarColor(backgroundColor: .background, titleColor: .white)
            .navigationTitle(title)
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
