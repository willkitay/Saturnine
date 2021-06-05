//
//  SpiritView.swift
//  QuazarV4
//
//  Created by Will on 4/15/21.
//

import SwiftUI
import Kingfisher

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
                datePicker
                ScrollView(showsIndicators: true) {
                    header
                    LazyVStack(alignment: .leading) {
                        if let photos = viewModel.spirit.photos {
                            ForEach(photos, id: \.id) { photo in
                                NavigationLink(destination: HorizontalSpiritFeed(id: photo.id, viewModel: viewModel)) {
                                    ImageView(title: photo.camera.name, url: photo.url)
                                }
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {  toolbarButton }
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
    
    var header: some View {
        VStack(alignment: .leading) {
            Image("SpiritLogo")
                .resizable()
                .scaledToFit()
                .padding(.top)
                .padding([.leading, .trailing], 40)
            FeedHeader(title: "Mars Spirit Rover", text: "Spirit, also known as MER-A or MER-2, is a robotic rover on Mars, active from 2004 to 2010. Spirit was operational on Mars for 2208 sols. It cost over 400 million USD and survived over twenty times longer than NASA planners expected.")
        }
    }
    
    var datePicker: some View {
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
    }
}

struct HorizontalSpiritFeed: View {
    @ObservedObject var viewModel: SpiritViewModel
    @State var id = 0
    
    init(id: Int, viewModel: SpiritViewModel) {
        _id = State(initialValue: id)
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    SpiritPageView(viewModel: viewModel, id: id)
                }
            }
        }
    }
}

struct SpiritPageView: View {
    @ObservedObject var viewModel: SpiritViewModel
    @State var id: Int
    
    var body: some View {
        TabView(selection: $id) {
            if let photos = viewModel.spirit.photos {
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
