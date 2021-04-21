//
//  POTDDetailView.swift
//  QuazarV4
//
//  Created by Will on 3/23/21.
//

import SwiftUI
import Kingfisher
//import ImageScrollView
import WebKit

struct POTDDetailView: View {
    var url: String
    var title: String
    var explanation: String
    var copyright: String
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
                    PhotoDetailsView(explanation: explanation, copyright: copyright, date: date, title: title)
                }
            }
            .navigationBarColor(backgroundColor: .background, titleColor: .white)
            .navigationTitle(title)
        }
    }
}
