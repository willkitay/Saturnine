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
                        NavigationLink(destination: POTDDetailView(photo: photo)) {
                            POTDImageView(photo: photo).onAppear() { self.elementOnAppear(photo) }
                        }
                        .padding(.bottom, 2)
                        .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
                        .navigationBarTitle("Picture of the Day", displayMode: .inline)
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
