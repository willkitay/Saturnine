//
//  ContentView.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var showingPictureOfTheDay = false
    @State private var showingHubbleNews = false
    @State private var showingHubbleRecentImages = false
    @State private var showingSpaceXLaunches = false
    var potdViewModel = POTDViewModel()
    var perseveranceViewModel = PerseveranceViewModel()
    var opportunityViewModel = OpportunityViewModel()
    var curiosityViewModel = CuriosityViewModel()
    var spiritViewModel = SpiritViewModel()
    var hubbleNewsViewModel = HubbleNewsViewModel()
    var hubbleRecentImagesViewModel = HubbleRecentImagesViewModel()
    var spaceXViewModel = SpaceXViewModel()

    init() {
        potdViewModel.loadPicturesOfTheDay()
        perseveranceViewModel.loadPerseverancePhotos()
        opportunityViewModel.loadOpportunityPhotos()
        curiosityViewModel.loadCuriosityPhotos()
        spiritViewModel.loadSpiritPhotos()
        hubbleNewsViewModel.loadNewsFeed()
        hubbleRecentImagesViewModel.loadRecentImages()
        spaceXViewModel.loadLaunchFeed()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        // Picture of the Day
                        NavigationLink(destination: VerticalPOTDView(viewModel: potdViewModel), isActive: $showingPictureOfTheDay) {
                            Button(action: {
                                showingPictureOfTheDay.toggle()
                            }) {
                                Text("Picture of the Day").modifier(CardChoiceView())
                            }
                        }
                        // Mars Rovers
                        MarsMenu(perseveranceViewModel: perseveranceViewModel, opportunityViewModel: opportunityViewModel, curiosityViewModel: curiosityViewModel, spiritViewModel: spiritViewModel)

                        NavigationLink(destination: HubbleNewsView(viewModel: hubbleNewsViewModel), isActive: $showingHubbleNews) {
                            Button(action: {
                                showingHubbleNews.toggle()
                            }) {
                                Text("Hubble News").modifier(CardChoiceView())
                            }
                        }

                        NavigationLink(destination: HubbleRecentImagesView(viewModel: hubbleRecentImagesViewModel), isActive: $showingHubbleRecentImages) {
                            Button(action: {
                                showingHubbleRecentImages.toggle()
                            }) {
                                Text("Hubble Telescope").modifier(CardChoiceView())
                            }
                        }

                        NavigationLink(destination: SpaceXView(viewModel: spaceXViewModel), isActive: $showingSpaceXLaunches) {
                            Button(action: {
                                showingSpaceXLaunches.toggle()
                            }) {
                                Text("SpaceX Launches").modifier(CardChoiceView())
                            }
                        }
                        
                    }
                    .padding()
                }
                .transition(.move(edge: .bottom))
                .animation(.linear)
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
