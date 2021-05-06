//
//  HomePageComponents.swift
//  Quasar
//
//  Created by Will on 5/6/21.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quasar")
                .font(.largeTitle).bold()
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom, 2.5)
            Text("Discover the cosmos")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.leading)
        }
    }
}

struct SectionTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .padding(.leading)
                .font(.callout.bold())
            Image(systemName: "arrow.right")
                .foregroundColor(.white)
                .font(.callout)
        }
    }
}

struct MostPopularView: ViewModifier {
    let text: String
    let subText: String
    func body(content: Content) -> some View {
        VStack {
            content
                .frame(width: 200, height: 250)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Text(text)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding(.leading)
                            }
                            HStack {
                                Text(subText)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                Spacer()
                            }
                        }.frame(width: 200, height: 250)
                        
                    }.frame(width: 200, height: 250)
                    
                    .padding(.bottom, 20)
                )
                .cornerRadius(25)
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.leading)
        }
    }
}

struct RegularCardView: ViewModifier {
    let text: String
    func body(content: Content) -> some View {
        VStack {
            content
                .frame(width: 125, height: 175)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Text(text)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                        }.frame(width: 125, height: 175)
                        
                    }.frame(width: 125, height: 175)
                    
                    .padding(.bottom, 20)
                )
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.leading)
        }
    }
}
