//
//  MarsRoverView.swift
//  QuazarV4
//
//  Created by Will on 3/31/21.
//

import SwiftUI

struct PerseveranceView: View {
    @ObservedObject var viewModel: PerseveranceViewModel
    @State private var showDatePicker = false
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 2, day: 18)
        let today = Date()
        return calendar.date(from: startComponents)! ... today
    }()
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                VStack {
                    
                    if showDatePicker {
                        DatePicker(
                            "Perseverance",
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
                        if viewModel.perseverance.photos != nil {
                            ForEach(viewModel.perseverance.photos!, id: \.id) { photo in
                                if let url = photo.url,
                                   let date = photo.earthDate,
                                   let sol = photo.sol,
                                   let rover = photo.rover?.name,
                                   let landingDate = photo.rover?.landingDate,
                                   let camera = photo.camera?.name,
                                   let cameraDescription = photo.camera?.fullName {
                                    NavigationLink(destination: RoverDetailView(url: url, date: date, sol: sol, rover: rover, landingDate: landingDate, camera: camera, cameraDescription: cameraDescription)) {
                                        RoverImage(url: url).onAppear()
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
        .navigationBarTitle("Perseverance Rover")
    }
}
