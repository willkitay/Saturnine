//
//  CuriosityView.swift
//  QuazarV4
//
//  Created by Will on 4/15/21.
//

import SwiftUI

struct CuriosityView: View {
    @ObservedObject var viewModel: CuriosityViewModel
    @State private var showDatePicker = false
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2012, month: 8, day: 6)
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
                            "Curiosity",
                            selection: $viewModel.date,
                            in: dateRange,
                            displayedComponents: .date)
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
                        if viewModel.curiosity.photos != nil {
                            ForEach(viewModel.curiosity.photos!, id: \.id) { photo in
                                if let url = photo.url,
                                   let date = photo.earthDate,
                                   let sol = photo.sol,
                                   let rover = photo.rover?.name,
                                   let landingDate = photo.rover?.landingDate,
                                   let camera = photo.camera?.name,
                                   let cameraDescription = photo.camera?.fullName {
                                    NavigationLink(destination: RoverDetailView(url: url, date: date, sol: sol, rover: rover, landingDate: landingDate, camera: camera, cameraDescription: cameraDescription)) {
                                        ImageView(title: camera, url: url)
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
        }.navigationBarTitle("Curiosity Rover")
    }
}
