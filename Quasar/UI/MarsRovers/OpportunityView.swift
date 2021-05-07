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
        .navigationBarTitle("Opportunity Rover")
    }
}
