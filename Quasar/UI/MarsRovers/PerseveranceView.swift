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
                    VStack(alignment: .leading) {
                        Image("PerseveranceLogo")
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                        FeedHeader(title: "Mars Perseverance Rover", text: "Perseverance's primary job is to seek signs of ancient life and collect samples of rock and regolith (broken rock and soil) for possible return to Earth. On 19 April 2021, the Ingenuity helicopter successfully completed the first powered controlled flight by an aircraft on a planet besides Earth.")
                    }
                    LazyVStack(alignment: .leading) {
                        if viewModel.perseverance.photos != nil {
                            ForEach(viewModel.perseverance.photos!, id: \.id) { photo in
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

//struct HorizontalPerseveranceFeed: View {
//    @ObservedObject var viewModel: PerseveranceViewModel
//    @State var currentTitle = ""
//
//    init(title: String, viewModel: PerseveranceViewModel) {
//        _currentTitle = State(initialValue: title)
//        self.viewModel = viewModel
//    }
//
//    var body: some View {
//        ZStack {
//            Color.background.edgesIgnoringSafeArea([.all])
//            ScrollView(.horizontal, showsIndicators: true) {
//                LazyHStack {
//                    PerseverancePageView(viewModel: viewModel, currentTitle: currentTitle)
//                }
//            }
//        }
//    }
//}

//struct PerseverancePageView: View {
//    @ObservedObject var viewModel: PerseveranceViewModel
//    @State var currentTitle: String
//
//    var body: some View {
//        TabView(selection: $currentTitle) {
////            if let images = viewModel.perseverance.photos {
//                ForEach(viewModel.perseverance.photos!, id: \.url) { photo in
//                    if let title = photo.title,
//                       let explanation = photo.explanation,
//                       let date = photo.date,
//                       let url = photo.url {
//                        ScrollView {
//                            NavigationLink(destination: FullScreenView(url: url, title: title)) {
//                                KFImage(URL(string: url))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                            }
//                                .onAppear() { elementOnAppear(photo) }
//                                .padding(.top, 63)
//                            PhotoDetailsView(explanation: explanation, date: date, title: title)
//                                .padding(.bottom, 55)
//                        }.tabItem {}.tag(title)
//                    }
//                }
////            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .tabViewStyle(PageTabViewStyle())
//    }
//}
