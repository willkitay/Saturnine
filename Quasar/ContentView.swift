//
//  ContentView.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    var potdViewModel = POTDViewModel()
    var perseveranceViewModel = PerseveranceViewModel()
    var opportunityViewModel = OpportunityViewModel()
    var curiosityViewModel = CuriosityViewModel()
    var spiritViewModel = SpiritViewModel()
    var esaViewModel = HubbleNewsViewModel()
    var hubbleRecentImagesViewModel = HubbleRecentImagesViewModel()
    var spaceXViewModel = SpaceXViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        Group {
                            Header()
                            GrayDivider()
                        }
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
                        Group {
                            SectionTitle(title: "Telescopes")
                            TelescopeOptions(hubbleImagesViewModel: hubbleRecentImagesViewModel)
                            GrayDivider()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GrayDivider: View {
    var body: some View {
        Divider().background(Color.gray).padding(10)
    }
}
