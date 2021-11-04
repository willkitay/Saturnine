//
//  HomePageViewOptions.swift
//  Quasar
//
//  Created by Will on 5/6/21.
//

import SwiftUI

struct MostPopularOptions: View {
    @State private var showingPictureOfTheDay = false
    @State private var showingSpaceXLaunches = false
    @State private var showingSpacecraft = false
    @State private var showingAstronauts = false
    @State private var showingEvents = false
    var potdViewModel: POTDViewModel
    var spaceXViewModel: SpaceXViewModel
    var spacecraftVM: SpacecraftVM
    var astronautVM: AstronautVM
    var eventVM: EventVM
    
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
                NavigationLink(destination: AstronautsView(viewModel: astronautVM), isActive: $showingAstronauts) {
                    Button(action: {
                        showingAstronauts.toggle()
                        astronautVM.loadAstronautList()
                    }) {
                        Image("Astronaut")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "Astronauts",  subText: "The trailblazers"))
                    }
                }
                NavigationLink(destination: EventView(viewModel: eventVM), isActive: $showingEvents) {
                    Button(action: {
                        eventVM.loadEventList()
                        showingEvents.toggle()
                    }) {
                        Image("EventLogo")
                            .resizable()
                            .scaledToFill()
                            .modifier(MostPopularView(text: "Events", subText: "What's happening today?"))
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


struct SolarSystemOptions: View {
    @State private var showingSun = false
    @State private var showingMercury = false
    @State private var showingVenus = false
    @State private var showingEarth = false
    @State private var showingMars = false
    @State private var showingJupiter = false
    @State private var showingSaturn = false
    @State private var showingNeptune = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                NavigationLink(destination: SunView(), isActive: $showingSun) {
                    Button(action: {
                        showingSun.toggle()
                    }) {
                        Image("sun")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "The Sun"))
                    }
                }
                NavigationLink(destination: MercuryView(), isActive: $showingMercury) {
                    Button(action: {
                        showingMercury.toggle()
                    }) {
                        Image("mercury")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Mercury"))
                    }
                }
                NavigationLink(destination: VenusView(), isActive: $showingVenus) {
                    Button(action: {
                        showingVenus.toggle()
                    }) {
                        Image("venus")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Venus"))
                    }
                }
                NavigationLink(destination: EarthView(), isActive: $showingEarth) {
                    Button(action: {
                        showingEarth.toggle()
                    }) {
                        Image("earth")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Earth"))
                    }
                }
                NavigationLink(destination: MarsView(), isActive: $showingMars) {
                    Button(action: {
                        showingMars.toggle()
                    }) {
                        Image("mars")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Mars"))
                    }
                }
                NavigationLink(destination: JupiterView(), isActive: $showingJupiter) {
                    Button(action: {
                        showingJupiter.toggle()
                    }) {
                        Image("jupiter")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Jupiter"))
                    }
                }
                NavigationLink(destination: SaturnView(), isActive: $showingSaturn) {
                    Button(action: {
                        showingSaturn.toggle()
                    }) {
                        Image("saturn")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Saturn"))
                    }
                }
                NavigationLink(destination: NeptuneView(), isActive: $showingNeptune) {
                    Button(action: {
                        showingNeptune.toggle()
                    }) {
                        Image("neptune")
                            .resizable()
                            .scaledToFill()
                            .modifier(RegularCardView(text: "Neptune"))
                    }
                }
            }
        }
    }
}
