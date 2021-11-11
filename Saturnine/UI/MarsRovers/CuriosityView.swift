//
//  CuriosityView.swift
//  Saturnine
//
//  Created by Will on 4/15/21.
//

import SwiftUI
import Kingfisher

struct CuriosityView: View {
    @ObservedObject var viewModel: CuriosityViewModel
    @State private var showDatePicker = false
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let landingDate = DateComponents(year: 2012, month: 8, day: 6)
        return calendar.date(from: landingDate)! ... Date()
    }()
    @State private var isGrid = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                datePicker
                ScrollView(showsIndicators: true) {
                    header
                    content
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { columnToGridButton }
            ToolbarItem(placement: .navigationBarTrailing) { toolbarButton }
        }
    }
    
    var content: some View {
        VStack {
            if viewModel.fetchSuccess == true {
                if isGrid {
                    gridView
                } else {
                    stackView
                }
            } else {
                if viewModel.fetchSuccess == false {
                    Text("No images available on this date.")
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                } else {
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
        }
    }
    
    var gridView: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0) {
            if let photos = viewModel.curiosity.photos {
                ForEach(photos, id: \.id) { photo in
                    NavigationLink(destination: HorizontalCuriosityFeed(id: photo.id, viewModel: viewModel)) {
                        GridView(title: photo.camera.name, url: photo.url)
                    }
                }.padding([.leading, .trailing], 5)
            }
        }
    }
    
    var stackView: some View {
        LazyVStack {
            if let photos = viewModel.curiosity.photos {
                ForEach(photos, id: \.id) { photo in
                    NavigationLink(destination: HorizontalCuriosityFeed(id: photo.id, viewModel: viewModel)) {
                        ImageView(title: photo.camera.name, url: photo.url)
                    }
                }
            }
        }
    }
    
    var datePicker: some View {
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
    
    var header: some View {
        VStack(alignment: .leading) {
            Image("CuriosityLogo")
                .resizable()
                .scaledToFit()
                .padding(.top)
                .padding([.leading, .trailing], 60)
            FeedHeader(title: "Mars Curiosity Rover", text: "Curiosity is a car-sized Mars rover designed to explore the Gale crater on Mars as part of NASA's Mars Science Laboratory mission. Curiosity was launched from Cape Canaveral on 26 November 2011.")
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

struct HorizontalCuriosityFeed: View {
    @ObservedObject var viewModel: CuriosityViewModel
    @State var id = 0
    
    init(id: Int, viewModel: CuriosityViewModel) {
        _id = State(initialValue: id)
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    curiosityTabViewCell
                }
            }
        }
    }
    
    var curiosityTabViewCell: some View {
        TabView(selection: $id) {
            if let photos = viewModel.curiosity.photos {
                ForEach(photos, id: \.id) { photo in
                    let cameraAcronym = photo.camera.name
                    let cameraName = photo.camera.fullName
                    ScrollView {
                        NavigationLink(destination: FullScreenView(url: photo.url, title: "")) {
                            KFImage(URL(string: photo.url)).resizable().scaledToFit()
                        }
                        .padding(.top, 62)
                        ImageInteractionTab(url: photo.url, title: "Mars Curiosity Rover", text: cameraName, date: formatDate(photo.earthDate))
                        RoverDescription(date: photo.earthDate, camera: cameraAcronym, cameraDescription: cameraName)
                    }.tag(photo.url)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}
