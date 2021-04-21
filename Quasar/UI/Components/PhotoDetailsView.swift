//
//  POTDExplanation.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI

struct PhotoDetailsView: View {
    var explanation: String
    var copyright: String
    var date: String
    var title: String
    
    var body: some View {
        VStack {
            PhotoTitle(title: title)
            Text(explanation)
                .padding()
                .lineSpacing(6)
                .cornerRadius(5)
            HStack {
                PhotoCopyright(copyright: copyright)
                    .padding()
            }
            PhotoDate(date: date)
                .padding(.bottom)
        }
        .background(Color.background2)
        .cornerRadius(5)
        .padding()
        .foregroundColor(.white)
    }
}

struct PhotoCopyright: View {
    var copyright: String
    var body: some View {
        VStack(alignment: .center) {
            Text(copyright)
        }
    }
}

struct PhotoDate: View {
    var date: String
    var body: some View {
        Text(date)
            .foregroundColor(.white)
    }
}

struct PhotoTitle: View {
    var title: String
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title)
                .padding()
                .foregroundColor(.white)
        }
    }
}
