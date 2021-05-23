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
                    VStack(alignment: .leading) {
                        Image("CuriosityLogo")
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                            .padding([.leading, .trailing], 60)
                        FeedHeader(title: "Mars Curiosity Rover", text: "Curiosity is a car-sized Mars rover designed to explore the Gale crater on Mars as part of NASA's Mars Science Laboratory mission. Curiosity was launched from Cape Canaveral on 26 November 2011.")
                    }
                    LazyVStack(alignment: .leading) {
                        if viewModel.curiosity.photos != nil {
                            ForEach(viewModel.curiosity.photos!, id: \.id) { photo in
                                NavigationLink(destination: RoverDetailView(url: photo.url, date: photo.earthDate, camera: photo.camera.name, cameraDescription: photo.camera.fullName)) {
                                    ImageView(title: photo.camera.name, url: photo.url)
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
    }
}
