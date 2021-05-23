//
//  HomePageViewOptions.swift
//  Quasar
//
//  Created by Will on 5/6/21.
//

import SwiftUI

struct TelescopeOptions: View {
    @State private var showingHubbleRecentImages = false
    var hubbleImagesViewModel: HubbleRecentImagesViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                NavigationLink(destination: HubbleRecentImagesView(viewModel: hubbleImagesViewModel), isActive: $showingHubbleRecentImages) {
                    Button(action: {
                        showingHubbleRecentImages.toggle()
                        hubbleImagesViewModel.loadRecentImages()
                    }) {
                        Image("HubbleTelescope")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Hubble"))
                    }
                }
            }
        }
    }
}

struct RoverOptions: View {
    @State private var showingPerseverance = false
    @State private var showingOpportunity = false
    @State private var showingCuriosity = false
    @State private var showingSpirit = false
    var perseveranceViewModel: PerseveranceViewModel
    var curiosityViewModel: CuriosityViewModel
    var opportunityViewModel: OpportunityViewModel
    var spiritViewModel: SpiritViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                NavigationLink(destination: PerseveranceView(viewModel: perseveranceViewModel), isActive: $showingPerseverance) {
                    Button(action: {
                        showingPerseverance.toggle()
                        perseveranceViewModel.loadPerseverancePhotos()
                    }) {
                        Image("Perseverance")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Perseverance"))
                    }
                }
                NavigationLink(destination: CuriosityView(viewModel: curiosityViewModel), isActive: $showingCuriosity) {
                    Button(action: {
                        showingCuriosity.toggle()
                        curiosityViewModel.loadCuriosityPhotos()
                    }) {
                        Image("Curiosity")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Curiosity"))
                    }
                }
                NavigationLink(destination: OpportunityView(viewModel: opportunityViewModel), isActive: $showingOpportunity) {
                    Button(action: {
                        showingOpportunity.toggle()
                        opportunityViewModel.loadOpportunityPhotos()
                    }) {
                        Image("Opportunity")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Opportunity"))
                    }
                }
                NavigationLink(destination: SpiritView(viewModel: spiritViewModel), isActive: $showingSpirit) {
                    Button(action: {
                        showingSpirit.toggle()
                        spiritViewModel.loadSpiritPhotos()
                    }) {
                        Image("Spirit")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Spirit"))
                    }
                }
            }
        }
    }
}

struct MostPopularOptions: View {
    @State private var showingPictureOfTheDay = false
    @State private var showingSpaceXLaunches = false
    @State private var showingHubbleNews = false
    var potdViewModel: POTDViewModel
    var spaceXViewModel: SpaceXViewModel
    var esaViewModel: ESAViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                NavigationLink(destination: VerticalPOTDView(viewModel: potdViewModel), isActive: $showingPictureOfTheDay) {
                    Button(action: {
                        showingPictureOfTheDay.toggle()
                        potdViewModel.loadPicturesOfTheDay()
                    }) {
                        Image("PictureOfTheDay")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "Picture of the Day", subText: "A curated gallery"))
                    }
                }
                NavigationLink(destination: SpaceXView(viewModel: spaceXViewModel), isActive: $showingSpaceXLaunches) {
                    Button(action: {
                        showingSpaceXLaunches.toggle()
                        spaceXViewModel.loadLaunchFeed()
                    }) {
                        Image("SpaceXRockets")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "SpaceX Rockets",  subText: "Sustainable exploration"))
                    }
                }
                NavigationLink(destination: ESANews(viewModel: esaViewModel), isActive: $showingHubbleNews) {
                    Button(action: {
                        showingHubbleNews.toggle()
                        esaViewModel.loadNewsFeed()
                    }) {
                        Image("HubbleNews")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "ESA", subText: "European Space Agency"))
                    }
                }
            }
        }
    }
}
