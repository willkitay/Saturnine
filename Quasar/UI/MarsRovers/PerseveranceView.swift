//
//  MarsRoverView.swift
//  QuazarV4
//
//  Created by Will on 3/31/21.
//

import SwiftUI
import Kingfisher

struct PerseveranceView: View {
    @ObservedObject var viewModel: PerseveranceViewModel
    @State private var showDatePicker = false
    private let perseveranceDescription = "Perseverance's primary job is to seek signs of ancient life and collect samples of rock and regolith (broken rock and soil) for possible return to Earth. On 19 April 2021, the Ingenuity helicopter successfully completed the first powered controlled flight by an aircraft on a planet besides Earth."
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let landingDate = DateComponents(year: 2021, month: 2, day: 18)
        return calendar.date(from: landingDate)! ... Date()
    }()
    @State private var isGrid = true
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                datePicker
                ScrollView(showsIndicators: true) {
                    header
                    if let photos = viewModel.perseverance.photos {
                        if isGrid {
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0) {
                                ForEach(photos, id: \.id) { photo in
                                    NavigationLink(destination: HorizontalPerseveranceFeed(id: photo.id, viewModel: viewModel)) {
                                        GridView(title: photo.camera.name, url: photo.url)
                                    }
                                }
                            }.padding([.leading, .trailing], 5)
                        } else {
                            LazyVStack {
                                ForEach(photos, id: \.id) { photo in
                                    NavigationLink(destination: HorizontalPerseveranceFeed(id: photo.id, viewModel: viewModel)) {
                                        ImageView(title: photo.camera.name, url: photo.url)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { columnToGridButton }
            ToolbarItem(placement: .navigationBarTrailing) { toolbarButton }
        }
    }
    
    var datePicker: some View {
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
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Image("PerseveranceLogo")
                .resizable()
                .scaledToFit()
                .padding(.top)
            FeedHeader(title: "Mars Perseverance Rover", text: perseveranceDescription)
        }
    }
    
    var toolbarButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                showDatePicker.toggle()
            }
        }) {
            Image(systemName: "ellipsis")
                .foregroundColor(.white)
        }
    }
    
    var columnToGridButton: some View {
        Button(action: {
            withAnimation(.default) {
                isGrid.toggle()
            }
        }) {
            if isGrid {
                Image(systemName: "rectangle.grid.1x2")
            } else {
                Image(systemName: "square.grid.3x3")
            }
        }
    }
}

struct HorizontalPerseveranceFeed: View {
    @ObservedObject var viewModel: PerseveranceViewModel
    @State var id = 0
    
    init(id: Int, viewModel: PerseveranceViewModel) {
        _id = State(initialValue: id)
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    perseveranceTabViewCell
                }
            }
        }
    }
    
    var perseveranceTabViewCell: some View {
        TabView(selection: $id) {
            ForEach(viewModel.perseverance.photos!, id: \.id) { photo in
                let cameraAcronym = photo.camera.name
                let cameraName = photo.camera.fullName
                ScrollView {
                    NavigationLink(destination: FullScreenView(url: photo.url, title: "")) {
                        KFImage(URL(string: photo.url)).resizable().scaledToFit()
                    }
                    .padding(.top, 62)
                    RoverDescription(date: photo.earthDate, camera: cameraAcronym, cameraDescription: cameraName)
                }.tag(id)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}
