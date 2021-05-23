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
                        VStack(alignment: .leading) {
                            Image("SpiritLogo")
                                .resizable()
                                .scaledToFit()
                                .padding(.top)
                                .padding([.leading, .trailing], 40)
                            FeedHeader(title: "Mars Spirit Rover", text: "Spirit, also known as MER-A or MER-2, is a robotic rover on Mars, active from 2004 to 2010. Spirit was operational on Mars for 2208 sols. It cost over 400 million USD and survived over twenty times longer than NASA planners expected.")
                        }
                        if viewModel.spirit.photos != nil {
                            ForEach(viewModel.spirit.photos!, id: \.id) { photo in
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
