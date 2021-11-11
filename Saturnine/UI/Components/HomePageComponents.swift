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
            HStack {
                title
                Spacer()
                NavigationLink(destination: ModalView(), isActive: $showModal) {
                    modalButton
                }
            }
            headerSubtext
        }
    }
    
    var title: some View {
        Text("Saturnine")
            .font(.custom("Default font design", size: 40)).bold()
            .foregroundColor(.white)
            .padding(.leading)
            .padding(.bottom, 2.5)
    }
    
    var modalButton: some View {
        Button(action: {
            showModal.toggle()
        }) {
            Image(systemName: "info.circle")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
                .padding(.trailing, 10)
        }
    }
    
    var headerSubtext: some View {
        Text("Discover the cosmos")
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.leading)
            .padding(.bottom, 25)
    }
}

struct ModalView: View {
    @State private var receivingPOTD = false
    private let about = "From staring through the eyes of the Perseverance rover to gazing at interstellar galaxies, Supernova will take you on a journey through our universe. Built for students, scientists, and passionate people."
    @State private var showingPrivacyPolicy = false
    @State private var showingTerms = false
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
//                    pictureOfTheDayNotification
//                    GrayDivider()
                    HStack {
                        privacyPolicy
                        Text("•")
                        termsAndConditions
                    }
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
            MailView(result: $contactUsRequest, recipients: ["SupernovaUserInteraction@gmail.com"]).edgesIgnoringSafeArea(.bottom)
               
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
            MailView(result: $bugReportRequest, recipients: ["SupernovaBugReport@gmail.com"]).edgesIgnoringSafeArea(.bottom)
        }
    }
    
//    var pictureOfTheDayNotification: some View {
//        Toggle(isOn: $receivingPOTD) {
//            Text("Picture of the Day").padding()
//            // TODO: add notification functionality
//
//        }.padding([.leading, .trailing])
//    }
    
    var privacyPolicy: some View {
        NavigationLink(destination: PrivacyPolicy(), isActive: $showingPrivacyPolicy) {
            Button(action: {
                showingPrivacyPolicy.toggle()
            }) {
                Text("Privacy Policy").font(.subheadline)
            }
        }
    }
    
    var termsAndConditions: some View {
        NavigationLink(destination: TermsAndConditions(), isActive: $showingTerms) {
            Button(action: {
                showingTerms.toggle()
            }) {
                Text("Terms & Conditions").font(.subheadline)
            }
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
                .font(.callout.bold())
        }
    }
}

struct MostPopularView: ViewModifier {
    let text: String
    let subText: String
    func body(content: Content) -> some View {
        VStack {
            content
                .frame(width: 200, height: 250)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Text(text)
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .padding(.leading)
                            }
                            HStack {
                                Text(subText)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                Spacer()
                            }
                        }.frame(width: 200, height: 250)
                    }
                    .frame(width: 200, height: 250)
                    .padding(.bottom, 20)
                )
                .cornerRadius(25)
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.leading)
        }
    }
}

struct ContactUs: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Contact Us")
                    .foregroundColor(.white)
            }.padding([.leading, .trailing])
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
            }.padding([.leading, .trailing])
        }
    }
}

struct TermsAndConditions: View {
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Terms & Conditions")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom)
                Text(termsAndConditions)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
            }.padding([.leading, .trailing])
        }
    }
}

struct RegularCardView: ViewModifier {
    let text: String
    func body(content: Content) -> some View {
        VStack {
            content
                .frame(width: 125, height: 175)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Text(text)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.leading, 5)
                                Spacer()
                            }
                        }
                        .frame(width: 125, height: 175)
                    }
                    .frame(width: 125, height: 175)
                    .padding(.bottom, 20)
                )
                .cornerRadius(15)
                .foregroundColor(.white)
                .font(.title2.bold())
                .padding(.leading)
        }
    }
}

struct HomePageComponent_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private let privacyPolicy =
"""
William Kitay built the Saturnine app as a Free app. This service is provided by William Kitay at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Saturnine unless otherwise defined in this Privacy Policy.

Information Collection and Use

For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third party services that may collect information used to identify you.

Link to privacy policy of third party service providers used by the app

Google Analytics for Firebase
Firebase Crashlytics
Log Data

I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

Cookies

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

I may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analyzing how our Service is used.
I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

Security

I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

Links to Other Sites

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

Children’s Privacy

These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.

Changes to This Privacy Policy

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2021-05-26

Contact Us

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at will.kitay@gmail.com.
"""

private let termsAndConditions =
"""
By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to William Kitay.

William Kitay is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.

The Saturnine app stores and processes personal data that you have provided to us, in order to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Saturnine app won’t work properly or at all.

The app does use third party services that declare their own Terms and Conditions.

Link to Terms and Conditions of third party service providers used by the app

Google Analytics for Firebase
Firebase Crashlytics
You should be aware that there are certain things that William Kitay will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but William Kitay cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.

If you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.

Along the same lines, William Kitay cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, William Kitay cannot accept responsibility.

With respect to William Kitay’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. William Kitay accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.

At some point, we may wish to update the app. The app is currently available on iOS – the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. William Kitay does not promise that it will always update the app so that it is relevant to you and/or works with the iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.

Changes to This Terms and Conditions

I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.

These terms and conditions are effective as of 2021-05-26

Contact Us

If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at will.kitay@gmail.com.
"""
