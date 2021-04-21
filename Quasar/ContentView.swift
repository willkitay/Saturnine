//
//  ContentView.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPictureOfTheDay = false
    @State private var showingHubbleNews = false
    var potdViewModel = POTDViewModel()
    var perseveranceViewModel = PerseveranceViewModel()
    var opportunityViewModel = OpportunityViewModel()
    var curiosityViewModel = CuriosityViewModel()
    var spiritViewModel = SpiritViewModel()
    var hubbleNewsViewModel = HubbleNewsViewModel()

    init() {
        potdViewModel.loadPicturesOfTheDay()
        perseveranceViewModel.loadPerseverancePhotos()
        opportunityViewModel.loadOpportunityPhotos()
        curiosityViewModel.loadCuriosityPhotos()
        spiritViewModel.loadSpiritPhotos()
        hubbleNewsViewModel.loadNewsFeed()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.edgesIgnoringSafeArea([.all])
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        // Picture of the Day
                        NavigationLink(destination: POTDView(viewModel: potdViewModel), isActive: $showingPictureOfTheDay) {
                            Button(action: {
                                showingPictureOfTheDay = true
                            }) {
                                Text("Picture of the Day").modifier(CardChoiceView())
                            }
                        }
                        // Mars Rovers
                        MarsMenu(perseveranceViewModel: perseveranceViewModel, opportunityViewModel: opportunityViewModel, curiosityViewModel: curiosityViewModel, spiritViewModel: spiritViewModel)
                        
                        NavigationLink(destination: HubbleNewsView(viewModel: hubbleNewsViewModel), isActive: $showingHubbleNews) {
                            Button(action: {
                                showingHubbleNews = true
                            }) {
                                Text("Hubble News").modifier(CardChoiceView())
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
            .navigationBarTitle("", displayMode: .inline)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardChoiceView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .frame(width: 360, height: 200)
            .background(Color.background3)
            .cornerRadius(15)
            .font(.largeTitle)
    }
}
