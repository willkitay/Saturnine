//
//  CuriosityView.swift
//  QuazarV4
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
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            VStack {
                datePicker
                ScrollView(showsIndicators: true) {
                    header
                    LazyVStack(alignment: .leading) {
                        if let photos = viewModel.curiosity.photos {
                            ForEach(photos, id: \.id) { photo in
                                NavigationLink(destination: HorizontalCuriosityFeed(id: photo.id, viewModel: viewModel)) {
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
                toolbarButton
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
                    CuriosityPageView(viewModel: viewModel, id: id)
                }
            }
        }
    }
}

struct CuriosityPageView: View {
    @ObservedObject var viewModel: CuriosityViewModel
    @State var id: Int
    
    var body: some View {
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
                        RoverDescription(date: photo.earthDate, camera: cameraAcronym, cameraDescription: cameraName)
                    }.tag(id)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}
