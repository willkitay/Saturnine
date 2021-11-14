//
//  HomePageComponents.swift
//  Saturnine
//
//  Created by Will on 5/6/21.
//

import SwiftUI
import MessageUI

struct Header: View {
    @State private var showModal = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image("Saturnine")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(15)
                    .padding([.leading, .top, .bottom])
                    .padding(.trailing, 5)
                VStack(alignment: .leading) {
                    title
                    headerSubtext
                }
                Spacer()
                NavigationLink(destination: ModalView(), isActive: $showModal) {
                    modalButton
                }
            }
        }
    }
    
    var title: some View {
        Text("Saturnine")
            .font(.custom("Default font design", size: 40)).bold()
            .foregroundColor(.white)
            .padding(.top)
    }
    
    var headerSubtext: some View {
        Text("Discover the cosmos")
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.leading, 3)
    }
    
    var modalButton: some View {
        Button(action: {
            showModal.toggle()
        }) {
            Image(systemName: "info.circle")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding([.top, .trailing])
                .padding(.trailing, 10)
                .padding(.top)
        }
    }
}

struct SectionTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom, 10)
                .font(.callout.bold())
        }
    }
}

struct LargeCardView: View {
    let image: String
    let text: String
    let subtext: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 250)
                .cornerRadius(25)
                .padding(.leading)
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.title2)
                        .minimumScaleFactor(0.5)
                        .padding(.leading, 30)
                    Spacer()
                }
                HStack {
                    Text(subtext)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                        .minimumScaleFactor(0.5)
                        .padding(.leading, 30)
                    Spacer()
                }
            }
        }
    }
}

struct ImageCardView: View {
    let image: String
    let text: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 175)
                .cornerRadius(15)
            VStack {
                Spacer()
                HStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
            }
            
        }.padding([.leading, .trailing], 10)
    }
}

struct TransparentCardView: View {
    let image: String
    let text: String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            HStack {
                Text(text)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 45)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            
        }.padding([.leading, .trailing], 5)
    }
}

struct ModalView: View {
    @State private var receivingPOTD = false
    private let about = "From staring through the eyes of the Mars rovers to gazing at interstellar galaxies, Saturnine will take you on a journey through our universe. Built for students, scientists, and passionate people."
    @State private var showingPrivacyPolicy = false
    @State var contactUsRequest: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingContactUs = false
    @State var bugReportRequest: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingBugReport = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack {
                modalTitle
                GrayDivider()
                appDescription
                GrayDivider()
                VStack {
                    HStack {
                        contactUsButton
                        Spacer()
                    }
                    HStack {
                        bugReportButton
                        Spacer()
                    }
                    GrayDivider()
                    privacyPolicy
                       
                }
                Spacer()
            }.foregroundColor(.white)
        }
    }
    
    var modalTitle: some View {
        Text("Saturnine").font(.largeTitle)
    }
    
    var appDescription: some View {
        Text(about).padding().font(.title3).multilineTextAlignment(.center)
    }
    
    var contactUsButton: some View {
        Button(action: {
            isShowingContactUs.toggle()
        }) {
            Image(systemName: "envelope").padding().padding(.leading).font(.title2)
            Text("Contact Us")
        }
        .disabled(!MFMailComposeViewController.canSendMail())
        .sheet(isPresented: $isShowingContactUs) {
            MailView(result: $contactUsRequest, recipients: ["SaturnineUserInteraction@gmail.com"]).edgesIgnoringSafeArea(.bottom)
               
        }
    }
    
    var bugReportButton: some View {
        Button(action: {
            isShowingBugReport.toggle()
        }) {
            Image(systemName: "exclamationmark.triangle").padding().padding(.leading).font(.title2)
            Text("Report a bug")
        }
        .disabled(!MFMailComposeViewController.canSendMail())
        .sheet(isPresented: $isShowingBugReport) {
            MailView(result: $bugReportRequest, recipients: ["SaturnineBugReport@gmail.com"]).edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var privacyPolicy: some View {
        NavigationLink(destination: PrivacyPolicy(), isActive: $showingPrivacyPolicy) {
            Button(action: {
                showingPrivacyPolicy.toggle()
            }) {
                Text("Privacy Policy").font(.subheadline)
            }
        }
    }
}

struct PrivacyPolicy: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Privacy Policy")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom)
                Text(privacyPolicy)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding()
            }.padding([.leading, .trailing])
        }
    }
}

struct HomePageComponent_Previews: PreviewProvider {
    static var previews: some View {
        TransparentCardView(image: "mars", text: "Mars")
    }
}

private let privacyPolicy = "Saturnine does not collect, use, save, or have access to any of your personal data. Individual settings relating to Saturnine are not personal and are stored only on your device. Saturnine complies with the Children’s Online Privacy Protection Act. Saturnine does not collect personal information from anyone, including children under the age of 13."
