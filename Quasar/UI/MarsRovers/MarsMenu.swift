//
//  MarsMenu.swift
//  QuazarV4
//
//  Created by Will on 4/11/21.
//

import SwiftUI

struct MarsMenu: View {
    @State private var expandOptions = false
    @State private var showingPerseverance = false
    @State private var showingOpportunity = false
    @State private var showingCuriosity = false
    @State private var showingSpirit = false
    
    var perseveranceViewModel: PerseveranceViewModel
    var opportunityViewModel: OpportunityViewModel
    var curiosityViewModel: CuriosityViewModel
    var spiritViewModel: SpiritViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Mars Rovers")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                        .animation(.spring())
                }
                if self.expandOptions {
                    VStack(spacing: 10) {
                        NavigationLink(destination: PerseveranceView(viewModel: perseveranceViewModel), isActive: $showingPerseverance) {
                            Button(action: {
                                showingPerseverance.toggle()
                            }) {
                                Text("Perseverance").modifier(MenuChoice())
                            }
                        }
                        NavigationLink(destination: OpportunityView(viewModel: opportunityViewModel), isActive: $showingOpportunity) {
                            Button(action: {
                                showingOpportunity.toggle()
                            }) {
                                Text("Opportunity").modifier(MenuChoice())
                            }
                        }
                        
                        NavigationLink(destination: CuriosityView(viewModel: curiosityViewModel), isActive: $showingCuriosity) {
                            Button(action: {
                                showingCuriosity.toggle()
                            }) {
                                Text("Curiosity").modifier(MenuChoice())
                            }
                        }
                        
                        NavigationLink(destination: SpiritView(viewModel: spiritViewModel), isActive: $showingSpirit) {
                            Button(action: {
                                showingSpirit.toggle()
                            }) {
                                Text("Spirit").modifier(MenuChoice())
                            }
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                    .transition(.move(edge: .top))
                }
            }
            .padding()
            .frame(width: 360, height: expandOptions ? 400 : 200)
            .background(Color.background3)
            .cornerRadius(15)
        }
        .onTapGesture {
            expandOptions.toggle()
        }
    }
}

struct MenuChoice: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 60, alignment: .center)
            .background(Color.paleGreen)
            .foregroundColor(.black)
            .font(.title3)
            .shadow(radius: 5)
            .cornerRadius(3)
            .animation(.spring())
    }
}
