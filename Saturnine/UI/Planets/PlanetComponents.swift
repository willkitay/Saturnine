//
//  PlanetComponents.swift
//  Saturnine
//
//  Created by William Kitay on 11/6/21.
//
import SwiftUI

struct planetTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 45, weight: .bold))
                .foregroundColor(.white)
                .padding([.leading, .trailing, .bottom])
            Spacer()
        }
    }
}

struct planetText: View {
    let text: String
    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .font(.callout)
            .foregroundColor(.white)
            .padding([.leading, .trailing])
    }
}

struct planetImage: View {
    let name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
}

struct planetImageSubtext: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.caption)
            .padding([.leading, .trailing], 8)
            .padding(.bottom)
    }
}
