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
    @StateObject var spaceXViewModel = SpaceXViewModel()
    @StateObject var spacecraftVM = SpacecraftVM()
    @StateObject var astronautVM = AstronautVM()
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
                                MostPopularOptions(potdViewModel: potdViewModel, spaceXViewModel: spaceXViewModel, spacecraftVM: spacecraftVM, astronautVM: astronautVM)
                                GrayDivider()
                            }
                            Group {
                                SectionTitle(title: "Mars Rovers")
                                RoverOptions(perseveranceViewModel: perseveranceViewModel, curiosityViewModel: curiosityViewModel, opportunityViewModel: opportunityViewModel, spiritViewModel: spiritViewModel)
                                GrayDivider()
                            }
                        } else {
                            FavoriteView()
                        }
                    }
                    Spacer()
                }
            }
            .onAppear() {
                spaceXViewModel.emptyData()
            }
            .navigationBarHidden(true)
            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
            .navigationBarTitle("", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var favoritesButton: some View {
        Group {
            HStack(spacing: 0) {
                Button(action: {
                    showingFavorites = false
                }) {
                    VStack {
                        Text("Home")
                            .foregroundColor(showingFavorites ? Color.gray : Color.white)
                            .contentShape(Rectangle())
                        Divider().background(showingFavorites ? Color.darkGray : Color.white)
                    }
                }.disabled(showingFavorites == false)
                Button(action: {
                    showingFavorites = true
                }) {
                    VStack {
                        Text("Favorites")
                            .foregroundColor(showingFavorites ? Color.white : Color.gray)
                            .contentShape(Rectangle())
                        Divider().background(showingFavorites ? Color.white : Color.darkGray)
                    }
                }.disabled(showingFavorites == true)
            }
        }
        .font(.caption)
        .padding(.bottom)
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
