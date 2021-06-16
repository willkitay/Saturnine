//
//  ContentView.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var potdViewModel = POTDViewModel()
    @StateObject var perseveranceViewModel = PerseveranceViewModel()
    @StateObject var opportunityViewModel = OpportunityViewModel()
    @StateObject var curiosityViewModel = CuriosityViewModel()
    @StateObject var spiritViewModel = SpiritViewModel()
    @StateObject var esaViewModel = HubbleNewsViewModel()
//    var hubbleRecentImagesViewModel = HubbleRecentImagesViewModel()
    @StateObject var spaceXViewModel = SpaceXViewModel()
    @State private var showingFavorites = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        Group {
                            Header()
                            favoritesButton
                        }
                        if !showingFavorites {
                            Group {
                                SectionTitle(title: "Most Popular")
                                MostPopularOptions(potdViewModel: potdViewModel, spaceXViewModel: spaceXViewModel, esaViewModel: esaViewModel)
                                GrayDivider()
                            }
                            Group {
                                SectionTitle(title: "Mars Rovers")
                                RoverOptions(perseveranceViewModel: perseveranceViewModel, curiosityViewModel: curiosityViewModel, opportunityViewModel: opportunityViewModel, spiritViewModel: spiritViewModel)
                                GrayDivider()
                            }
                        } else {
                            favorites
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
            .navigationBarTitle("", displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var favoritesButton: some View {
        Group {
            HStack(spacing: 0) {
                VStack {
                    Button(action: {
                        showingFavorites = false
                    }) {
                        Text("Home").foregroundColor(showingFavorites ? Color.gray : Color.white)
                    }
                    Divider().background(showingFavorites ? Color.darkGray : Color.white)
                }
                VStack {
                    Button(action: {
                        showingFavorites = true
                    }) {
                        Text("Favorites").foregroundColor(showingFavorites ? Color.white : Color.gray)
                    }
                    Divider().background(showingFavorites ? Color.white : Color.darkGray)
                }
            }
        }
        .font(.caption)
        .padding(.bottom)
    }
    
    var favorites: some View {
        Text("Test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct GrayDivider: View {
    var body: some View {
        Divider().background(Color.gray).padding(10)
    }
}
