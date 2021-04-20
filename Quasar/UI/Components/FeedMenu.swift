//
//  SolTracker.swift
//  QuazarV4
//
//  Created by Will on 4/12/21.
//

import SwiftUI

struct FeedMenu: View {
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .frame(width: 70, height: 30)
//                .foregroundColor(.background2)
//                .opacity(0.9)
//                .cornerRadius(10)
//                .padding(.trailing)
            VStack(spacing: 5) {
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
            }
                .font(.system(size: 1))
                .opacity(0.8)
                .padding(.trailing)
                .foregroundColor(.white)
        }
    }
}

//struct SolTracker: View {
//    @State var count = 1
//    private(set) var minSol = 1
//    var maxSol: Int
//
//    var body: some View {
//        VStack {
//            Picker(selection: $count, label: Text("Sol \(count)")) {
//                ForEach(minSol ..< maxSol) { index in
//                    Text("\(index)")
//                }
//                .rotationEffect(Angle(degrees: 90))
//                .foregroundColor(.white)
//            }
//            .background(Color.background)
//            .rotationEffect(Angle(degrees: -90))
//            .frame(height: 50)
//            .clipped()
//        }
//    }
//}
