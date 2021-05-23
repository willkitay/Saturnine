//
//  HomePageComponents.swift
//  Quasar
//
//  Created by Will on 5/6/21.
//

import SwiftUI

struct Header: View {
    @State private var showModal = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Quasar")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.bottom, 2.5)
                Spacer()
                Button(action: {
                    showModal.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.trailing, 10)
                }.sheet(isPresented: $showModal) {
                    ModalView()
                }
            }
            Text("Discover the cosmos")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.leading)
        }
    }
}

struct ModalView: View {
    @State private var receivingPOTD = false
    private let about = "From staring through the eyes of the Perseverance rover to gazing at interstellar galaxies, Quasar will take you on a journey through our universe. Built for students, scientists, and passionate people."
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Quasar").align(.centerX).font(.largeTitle).padding(.top)
                GrayDivider()
                Text(about).padding().font(.title3).multilineTextAlignment(.center)
                GrayDivider()
                VStack {
                    HStack {
                        Image(systemName: "envelope").padding().padding(.leading).font(.title2)
                        Text("Contact Us")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: "info.circle").padding().padding(.leading).font(.title2)
                        Text("FAQ")
                        Spacer()
                    }
                    GrayDivider()
                    Toggle(isOn: $receivingPOTD) {
                        Text("Picture of the Day").padding()
                    }.padding([.leading, .trailing])
                    GrayDivider()
                    Text("Privacy Policy • Terms of Service").font(.subheadline)
                }
                Spacer()
            }
            .foregroundColor(.white)
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
                        }
                        .frame(width: 125, height: 175)
                    }
                    .frame(width: 125, height: 175)
                    .padding(.bottom, 20)
                )
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.leading)
        }
    }
}

struct HomePageComponent_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
