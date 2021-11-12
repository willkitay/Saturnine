//
//  HomePageViewOptions.swift
//  Saturnine
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
                        LargeCardView(image: "PictureOfTheDay", text: "Picture of the Day", subtext: "A curated gallery")
                    }
                }
                NavigationLink(destination: SpaceXView(viewModel: spaceXViewModel), isActive: $showingSpaceXLaunches) {
                    Button(action: {
                        showingSpaceXLaunches.toggle()
                        spaceXViewModel.loadLaunchFeed()
                    }) {
                        LargeCardView(image: "SpaceXRockets", text: "SpaceX Rockets", subtext: "Sustainable exploration")
                    }
                }
                NavigationLink(destination: SpacecraftView(viewModel: spacecraftVM), isActive: $showingSpacecraft) {
                    Button(action: {
                        showingSpacecraft.toggle()
                        spacecraftVM.loadSpacecraftList()
                    }) {
                        LargeCardView(image: "Spaceship", text: "Spacecraft", subtext: "Our link to the final frontier")
                    }
                }
                NavigationLink(destination: AstronautsView(viewModel: astronautVM), isActive: $showingAstronauts) {
                    Button(action: {
                        showingAstronauts.toggle()
                        astronautVM.loadAstronautList()
                    }) {
                        LargeCardView(image: "Astronaut", text: "Astronauts", subtext: "The trailblazers")
                    }
                }
                NavigationLink(destination: EventView(viewModel: eventVM), isActive: $showingEvents) {
                    Button(action: {
                        eventVM.loadEventList()
                        showingEvents.toggle()
                    }) {
                        LargeCardView(image: "EventLogo", text: "Events", subtext: "What's happening today?")
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
                        ImageCardView(image: "Perseverance", text: "Perseverance")
                    }
                }
                NavigationLink(destination: CuriosityView(viewModel: curiosityViewModel), isActive: $showingCuriosity) {
                    Button(action: {
                        showingCuriosity.toggle()
                        curiosityViewModel.loadCuriosityPhotos()
                    }) {
                        ImageCardView(image: "Curiosity", text: "Curiosity")
                    }
                }
                NavigationLink(destination: OpportunityView(viewModel: opportunityViewModel), isActive: $showingOpportunity) {
                    Button(action: {
                        showingOpportunity.toggle()
                        opportunityViewModel.loadOpportunityPhotos()
                    }) {
                        ImageCardView(image: "Opportunity", text: "Opportunity")
                    }
                }
                NavigationLink(destination: SpiritView(viewModel: spiritViewModel), isActive: $showingSpirit) {
                    Button(action: {
                        showingSpirit.toggle()
                        spiritViewModel.loadSpiritPhotos()
                    }) {
                        ImageCardView(image: "Spirit", text: "Spirit")
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
    @State private var showingUranus = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                NavigationLink(destination: SunView(), isActive: $showingSun) {
                    Button(action: { showingSun.toggle() }) {
                        TransparentCardView(image: "sun", text: "The Sun")
                    }
                }
                NavigationLink(destination: MercuryView(), isActive: $showingMercury) {
                    Button(action: { showingMercury.toggle() }) {
                        TransparentCardView(image: "mercury", text: "Mercury")
                    }
                }
                NavigationLink(destination: VenusView(), isActive: $showingVenus) {
                    Button(action: { showingVenus.toggle() }) {
                        TransparentCardView(image: "venus", text: "Venus")
                    }
                }
                NavigationLink(destination: EarthView(), isActive: $showingEarth) {
                    Button(action: { showingEarth.toggle() }) {
                        TransparentCardView(image: "earth", text: "Earth")
                    }
                }
                NavigationLink(destination: MarsView(), isActive: $showingMars) {
                    Button(action: { showingMars.toggle() }) {
                        TransparentCardView(image: "mars", text: "Mars")
                    }
                }
                NavigationLink(destination: JupiterView(), isActive: $showingJupiter) {
                    Button(action: { showingJupiter.toggle() }) {
                        TransparentCardView(image: "jupiter", text: "Jupiter")
                    }
                }
                NavigationLink(destination: SaturnView(), isActive: $showingSaturn) {
                    Button(action: {  showingSaturn.toggle() }) {
                        TransparentCardView(image: "saturn", text: "Saturn")
                    }
                }
                NavigationLink(destination: UranusView(), isActive: $showingUranus) {
                    Button(action: { showingUranus.toggle() }) {
                        TransparentCardView(image: "uranus", text: "Uranus")
                    }
                }
                NavigationLink(destination: NeptuneView(), isActive: $showingNeptune) {
                    Button(action: { showingNeptune.toggle() }) {
                        TransparentCardView(image: "neptune", text: "Neptune")
                    }
                }
            }
        }
    }
}

struct HomePageViewOptionsPreview: PreviewProvider {
    static var previews: some View {
        SolarSystemOptions()
    }
}
