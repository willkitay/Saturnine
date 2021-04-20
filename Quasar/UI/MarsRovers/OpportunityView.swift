//
//  OpportunityView.swift
//  QuazarV4
//
//  Created by Will on 4/15/21.
//

import SwiftUI

struct OpportunityView: View {
    @ObservedObject var viewModel: OpportunityViewModel
    @State private var showDatePicker = false
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2004, month: 1, day: 25)
        let endComponents = DateComponents(year: 2018, month: 6, day: 11)
        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                VStack {
                    if showDatePicker {
                        DatePicker(
                            "Opportunity",
                            selection: $viewModel.date,
                            in: dateRange,
                            displayedComponents: .date
                        )
                        .onChange(of: viewModel.date, perform: { _ in
                            withAnimation {
                                showDatePicker = false
                            }
                        })
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .colorScheme(.dark)
                        .accentColor(.paleGreen)
                    }
                }.animation(.easeInOut)
                
                ScrollView(showsIndicators: true) {
                    LazyVStack(alignment: .leading) {
                        if viewModel.opportunity.photos != nil {
                            ForEach(viewModel.opportunity.photos!, id: \.id) { photo in
                                if let url = photo.url,
                                   let date = photo.earthDate,
                                   let sol = photo.sol,
                                   let rover = photo.rover?.name,
                                   let landingDate = photo.rover?.landingDate,
                                   let camera = photo.camera?.name,
                                   let cameraDescription = photo.camera?.fullName {
                                    NavigationLink(destination: RoverDetailView(url: url, date: date, sol: sol, rover: rover, landingDate: landingDate, camera: camera, cameraDescription: cameraDescription)) {
                                        RoverImage(url: url).onAppear()
//                                            .overlay(TitleOverlay(text: "Sol " + String(sol)), alignment: .bottomTrailing)
                                            .padding([.leading, .trailing])
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation(.easeInOut) {
                        showDatePicker.toggle()
                    }
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarTitle("Opportunity Rover")
    }
}
