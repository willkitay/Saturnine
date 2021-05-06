//
//  SpiritView.swift
//  QuazarV4
//
//  Created by Will on 4/15/21.
//

import SwiftUI

struct SpiritView: View {
    @ObservedObject var viewModel: SpiritViewModel
    @State private var showDatePicker = false
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2004, month: 1, day: 4)
        let endComponents = DateComponents(year: 2010, month: 3, day: 21)
        return calendar.date(from: startComponents)! ... calendar.date(from: endComponents)!
    }()
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                VStack {
                    if showDatePicker {
                        DatePicker(
                            "Spirit",
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
                        if viewModel.spirit.photos != nil {
                            ForEach(viewModel.spirit.photos!, id: \.id) { photo in
                                if let url = photo.url,
                                   let date = photo.earthDate,
                                   let camera = photo.camera?.name,
                                   let cameraDescription = photo.camera?.fullName {
                                    NavigationLink(destination: RoverDetailView(url: url, date: date, camera: camera, cameraDescription: cameraDescription)) {
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
        }
        .navigationBarTitle("Spirit Rover")
    }
}
