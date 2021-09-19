//
//  HomePageViewOptions.swift
//  Quasar
//
//  Created by Will on 5/6/21.
//

import SwiftUI

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
    @State private var showingSpacecraft = false
    var potdViewModel: POTDViewModel
    var spaceXViewModel: SpaceXViewModel
    var spacecraftVM: SpacecraftVM
    
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
                NavigationLink(destination: SpacecraftView(viewModel: spacecraftVM), isActive: $showingSpacecraft) {
                    Button(action: {
                        showingSpacecraft.toggle()
                        spacecraftVM.loadSpacecraftList()
                    }) {
                        Image("Spaceship")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "Spacecraft",  subText: "Our link to the final frontier"))
                    }
                }
            }
        }
    }
}
