//
//  ImageAttributes.swift
//  QuazarV4
//
//  Created by Will on 4/11/21.
//

import SwiftUI
import Kingfisher

struct TitleOverlay: View {
    var text: String
    var body: some View {
        ZStack {
            Text(text)
                .font(.caption)
                .padding(6)
                .foregroundColor(.white)
        }
        .background(Color.black)
        .opacity(0.7)
        .cornerRadius(10)
        .padding(5)
    }
}
